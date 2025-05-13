part of '../collection_list.dart';

class _DraggableCollection extends StatelessWidget {
  const _DraggableCollection({
    required this.collectionData,
    required this.isDraggable,
  });

  final CollectionData collectionData;
  final bool isDraggable;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final CollectionListCubit cubit =
        BlocProvider.of<CollectionListCubit>(context);
    final HomepageCubit homepageCubit = BlocProvider.of<HomepageCubit>(context);

    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return LongPressDraggable<CollectionData>(
        onDragStarted: () {
          cubit.isDragging = true;
          homepageCubit.isEnabled = false;
        },
        onDragEnd: (_) {
          cubit.isDragging = false;
          homepageCubit.isEnabled = true;
        },
        onDragCompleted: () async {
          CollectionRepository.delete(collectionData);
          cubit.refresh();

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(appLocalizations.deleteCollectionSuccessfully),
            ),
          );
        },
        data: collectionData,
        maxSimultaneousDrags: isDraggable ? 1 : 0,
        feedback: DraggableFeedbackWidget(
          width: constraints.maxWidth,
          child: _CollectionWidget(collectionData),
        ),
        childWhenDragging: DraggablePlaceholderWidget(
          width: constraints.maxWidth,
          child: _CollectionWidget(collectionData),
        ),
        child: _CollectionWidget(
          collectionData,
          onTap: () {
            Navigator.of(context)
                .push(
                  RouteUtils.defaultRoute(
                    CollectionViewer(collectionData: collectionData),
                  ),
                )
                .then((_) => cubit.refresh());
          },
        ),
      );
    });
  }
}
