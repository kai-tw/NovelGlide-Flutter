import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/loading_state_code.dart';
import '../common_components/common_list_empty.dart';
import '../common_components/common_loading.dart';
import 'bloc/collection_list_bloc.dart';

class CollectionListSliverList extends StatelessWidget {
  const CollectionListSliverList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CollectionListCubit, CollectionListState>(
      buildWhen: (previous, current) =>
          previous.code != current.code || previous.collectionList != current.collectionList,
      builder: (context, state) {
        switch (state.code) {
          case LoadingStateCode.initial:
          case LoadingStateCode.loading:
            return const CommonSliverLoading();

          case LoadingStateCode.loaded:
            if (state.collectionList.isEmpty) {
              return const CommonSliverListEmpty();
            } else {
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return ListTile(
                      title: Text(state.collectionList[index].name),
                    );
                  },
                  childCount: state.collectionList.length,
                ),
              );
            }
        }
      },
    );
  }
}
