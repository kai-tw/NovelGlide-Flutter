part of '../collection_viewer.dart';

class _PopupMenuButton extends StatelessWidget {
  const _PopupMenuButton();

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: const Icon(Icons.more_vert_rounded),
      itemBuilder: _itemBuilder,
    );
  }

  List<PopupMenuEntry<dynamic>> _itemBuilder(BuildContext context) {
    final cubit = BlocProvider.of<_Cubit>(context);
    final isLoaded = cubit.state.code.isLoaded;
    List<PopupMenuEntry<dynamic>> entries = [];

    /// Selecting mode
    if (isLoaded && !cubit.state.isSelecting) {
      entries.add(
        PopupMenuItem(
          onTap: () => cubit.setSelecting(true),
          child: const CommonListSelectModeButton(),
        ),
      );
    }

    /// Operation Section
    if (isLoaded && cubit.state.isSelecting) {
      entries.add(
        PopupMenuItem(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) {
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
