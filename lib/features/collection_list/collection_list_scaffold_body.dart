part of 'collection_list.dart';

class CollectionListScaffoldBody extends StatelessWidget {
  const CollectionListScaffoldBody({super.key});

  @override
  Widget build(BuildContext context) {
    final HomepageCubit homepageCubit = BlocProvider.of<HomepageCubit>(context);
    final CollectionListCubit cubit =
        BlocProvider.of<CollectionListCubit>(context);
    return PageStorage(
      bucket: homepageCubit.collectionBucket,
      child: RefreshIndicator(
        onRefresh: cubit.refresh,
        child: const Scrollbar(
          child: CustomScrollView(
            key: PageStorageKey<String>('homepage-collection'),
            slivers: <Widget>[
              CollectionList(),
            ],
          ),
        ),
      ),
    );
  }
}
