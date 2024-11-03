part of '../collection_list.dart';

class _DraggableCollection extends StatelessWidget {
  final CollectionData _data;

  const _DraggableCollection(this._data);

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final cubit = BlocProvider.of<CollectionListCubit>(context);

    return LayoutBuilder(builder: (context, constraints) {
      return LongPressDraggable(
        onDragStarted: () => cubit.setDragging(true),
        onDragEnd: (_) => cubit.setDragging(false),
        onDragCompleted: () async {
          CollectionRepository.delete(_data);
          cubit.refresh();

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(appLocalizations.deleteBookmarkSuccessfully),
            ),
          );
        },
        data: _data,
        feedback: DraggableFeedbackWidget(
          width: constraints.maxWidth,
          child: _CollectionWidget(_data),
        ),
        childWhenDragging: DraggablePlaceholderWidget(
          width: constraints.maxWidth,
          child: _CollectionWidget(_data),
        ),
        child: _CollectionWidget(
          _data,
          onTap: () {
            Navigator.of(context)
                .push(
                  RouteUtils.pushRoute(
                    CollectionViewer(collectionData: _data),
                  ),
                )
                .then((_) => cubit.refresh());
          },
        ),
      );
    });
  }
}
