import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../homepage/cubit/homepage_cubit.dart';
import 'collection_list.dart';
import 'cubit/collection_list_cubit.dart';

class CollectionListScaffoldBody extends StatelessWidget {
  const CollectionListScaffoldBody({super.key});

  @override
  Widget build(BuildContext context) {
    final HomepageCubit homepageCubit = BlocProvider.of<HomepageCubit>(context);
    final CollectionListCubit cubit =
        BlocProvider.of<CollectionListCubit>(context);

    return Column(
      children: <Widget>[
        Expanded(
          child: PageStorage(
            bucket: homepageCubit.collectionListBucket,
            child: RefreshIndicator(
              onRefresh: cubit.refresh,
              notificationPredicate: (_) => cubit.state.canRefresh,
              child: const Scrollbar(
                child: CustomScrollView(
                  key: PageStorageKey<String>('homepage-collection'),
                  slivers: <Widget>[
                    CollectionList(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
