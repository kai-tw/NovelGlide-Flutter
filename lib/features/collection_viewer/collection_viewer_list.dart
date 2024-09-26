import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/book_data.dart';
import '../../enum/loading_state_code.dart';
import '../../toolbox/route_helper.dart';
import '../common_components/common_list_empty.dart';
import '../common_components/common_loading.dart';
import '../table_of_contents/table_of_content.dart';
import 'bloc/collection_viewer_bloc.dart';

class CollectionViewerList extends StatelessWidget {
  const CollectionViewerList({super.key});

  @override
  Widget build(BuildContext context) {
    final CollectionViewerCubit cubit = BlocProvider.of<CollectionViewerCubit>(context);

    return BlocBuilder<CollectionViewerCubit, CollectionViewerState>(
      buildWhen: (previous, current) => previous.code != current.code || previous.bookList != current.bookList,
      builder: (context, state) {
        switch (state.code) {
          case LoadingStateCode.initial:
          case LoadingStateCode.loading:
            return const CommonLoading();

          case LoadingStateCode.loaded:
            if (state.bookList.isEmpty) {
              return const Center(
                child: CommonListEmpty(),
              );
            } else {
              return ReorderableListView.builder(
                onReorder: cubit.reorder,
                itemCount: state.bookList.length,
                itemBuilder: (context, index) {
                  final BookData data = state.bookList[index];
                  return ListTile(
                    key: ValueKey(data.filePath),
                    onTap: () {
                      Navigator.of(context)
                          .push(RouteHelper.pushRoute(TableOfContents(data)))
                          .then((_) => cubit.refresh());
                    },
                    leading: const Icon(Icons.book_outlined),
                    title: Text(data.name),
                    trailing: const Icon(Icons.drag_handle_rounded),
                  );
                },
              );
            }
        }
      },
    );
  }
}
