part of '../../collection_service.dart';

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
            bucket: homepageCubit.collectionBucket,
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
