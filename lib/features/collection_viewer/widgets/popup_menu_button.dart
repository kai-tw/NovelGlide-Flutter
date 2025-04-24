part of '../collection_viewer.dart';

class _PopupMenuButton extends StatelessWidget {
  const _PopupMenuButton();

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

    /// Selecting mode
    if (isLoaded && !cubit.state.isSelecting) {
      entries.add(
        PopupMenuItem<void>(
          onTap: () => cubit.setSelecting(true),
          child: const CommonListSelectModeButton(),
        ),
      );
    }

    /// Operation Section
    if (isLoaded && cubit.state.isSelecting) {
      entries.add(
        PopupMenuItem<void>(
          onTap: () {
            showDialog(
              context: context,
              builder: (_) {
                return CommonDeleteDialog(
                  onDelete: () => cubit.remove(),
                );
              },
            );
          },
          enabled: cubit.state.selectedSet.isNotEmpty,
          child: const CommonListDeleteButton(),
        ),
      );
    }

    return entries;
  }
}
