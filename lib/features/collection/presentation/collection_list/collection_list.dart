part of '../../collection_service.dart';

class CollectionList extends StatelessWidget {
  const CollectionList({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final WindowSize windowClass = WindowSize.of(context);

    BlocProvider.of<CollectionListCubit>(context).refresh();

    return BlocBuilder<CollectionListCubit, CollectionListState>(
      buildWhen: (CollectionListState previous, CollectionListState current) =>
          previous.code != current.code ||
          previous.dataList != current.dataList ||
          previous.listType != current.listType,
      builder: (BuildContext context, CollectionListState state) {
        switch (state.code) {
          case LoadingStateCode.initial:
          case LoadingStateCode.loading:
          case LoadingStateCode.backgroundLoading:
            // Loading...
            return const CommonSliverLoading();

          case LoadingStateCode.loaded:
            if (state.dataList.isEmpty) {
              // No Collections.
              return SharedListSliverEmpty(
                title: appLocalizations.collectionNoCollection,
              );
            } else {
              // Show Collection List.
              return SliverPadding(
                padding: EdgeInsets.only(
                  top: windowClass == WindowSize.compact ? 0.0 : 16.0,
                  bottom: MediaQuery.paddingOf(context).bottom + 72.0,
                ),
                sliver: SharedList(
                  listType: state.listType,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 150.0,
                    childAspectRatio: 150 / 180,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return CollectionListItem(
                        collectionData: state.dataList[index],
                      );
                    },
                    childCount: state.dataList.length,
                  ),
                ),
              );
            }
        }
      },
    );
  }
}
