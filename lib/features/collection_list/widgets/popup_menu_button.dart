part of '../collection_list.dart';

class _PopupMenuButton extends StatelessWidget {
  const _PopupMenuButton();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CollectionListCubit, _State>(
      buildWhen: (previous, current) => previous.code != current.code,
      builder: (context, state) {
        return PopupMenuButton(
          enabled: state.code == LoadingStateCode.loaded,
          icon: const Icon(Icons.more_vert_rounded),
          clipBehavior: Clip.hardEdge,
          itemBuilder: _itemBuilder,
        );
      },
    );
  }

  List<PopupMenuEntry> _itemBuilder(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final cubit = BlocProvider.of<CollectionListCubit>(context);
    final state = cubit.state;

    List<PopupMenuEntry> entries = [];

    /// Selecting mode
    if (state.code.isLoaded && !state.isSelecting) {
      entries.addAll([
        PopupMenuItem(
          onTap: () => cubit.setSelecting(true),
          child: ListTile(
            leading: const SizedBox(width: 24.0),
            title: Text(appLocalizations.generalSelect),
            trailing: const Icon(Icons.check_circle_outline_rounded),
          ),
        ),
        const PopupMenuDivider(),
      ]);
    }

    /// Sorting Section
    final sortMap = {
      SortOrderCode.name: appLocalizations.generalName,
    };

    for (final entry in sortMap.entries) {
      final isSelected = state.sortOrder == entry.key;
      entries.add(
        PopupMenuItem(
          onTap: () {
            isSelected
                ? cubit.setListOrder(isAscending: !state.isAscending)
                : cubit.setListOrder(sortOrder: entry.key);
          },
          child: CommonPopupMenuSortListTile(
            isSelected: isSelected,
            isAscending: state.isAscending,
            title: entry.value,
          ),
        ),
      );
    }

    /// Operation Section
    if (state.code.isLoaded && state.isSelecting) {
      entries.addAll([
        const PopupMenuDivider(),
        PopupMenuItem(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) {
                return CommonDeleteDialog(
                  onDelete: () => cubit.deleteSelectedCollections(),
                );
              },
            );
          },
          enabled: state.selectedSet.isNotEmpty,
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            dense: true,
            leading: const Icon(Icons.delete_rounded),
            title: Text(appLocalizations.generalDelete),
          ),
        ),
      ]);
    }

    return entries;
  }
}
