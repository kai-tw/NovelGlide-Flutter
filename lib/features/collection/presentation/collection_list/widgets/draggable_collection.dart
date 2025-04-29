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

    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return LongPressDraggable<CollectionData>(
        onDragStarted: () => cubit.setDragging(true),
        onDragEnd: (_) => cubit.setDragging(false),
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
                  RouteUtils.pushRoute(
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
