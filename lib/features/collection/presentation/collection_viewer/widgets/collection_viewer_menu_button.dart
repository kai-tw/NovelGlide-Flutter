part of '../collection_viewer.dart';

class CollectionViewerMenuButton extends StatelessWidget {
  const CollectionViewerMenuButton({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<void>(
      icon: const Icon(Icons.more_vert_rounded),
      clipBehavior: Clip.hardEdge,
      itemBuilder: _itemBuilder,
    );
  }

  List<PopupMenuEntry<void>> _itemBuilder(BuildContext context) {
    final CollectionViewerCubit cubit =
        BlocProvider.of<CollectionViewerCubit>(context);
    final bool isLoaded = cubit.state.code.isLoaded;
    final List<PopupMenuEntry<void>> entries = <PopupMenuEntry<void>>[];

    // Selecting mode button
    if (isLoaded &&
        !cubit.state.isSelecting &&
        cubit.state.dataList.isNotEmpty) {
      entries.addAll(<PopupMenuEntry<void>>[
        PopupMenuItem<void>(
          onTap: () => cubit.isSelecting = true,
          child: const SharedListSelectModeTile(),
        ),
        const PopupMenuDivider(),
      ]);
    }

    // Operation Section
    if (isLoaded && cubit.state.isSelecting) {
      // The button that removes selected books from collection.
      entries.add(_buildDeleteButton(context));
    }

    return entries;
  }

  PopupMenuEntry<void> _buildDeleteButton(BuildContext context) {
    final CollectionViewerCubit cubit =
        BlocProvider.of<CollectionViewerCubit>(context);
    return PopupMenuItem<void>(
      onTap: () {
        showDialog(
          context: context,
          builder: (_) {
            return CommonDeleteDialog(
              onDelete: cubit.remove,
            );
          },
        );
      },
      enabled: cubit.state.selectedSet.isNotEmpty,
      child: const SharedListDeleteButton(),
    );
  }
}
