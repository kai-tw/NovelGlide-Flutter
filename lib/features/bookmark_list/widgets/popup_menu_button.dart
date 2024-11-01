part of '../bookmark_list.dart';

class _PopupMenuButton extends StatelessWidget {
  const _PopupMenuButton();

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final cubit = BlocProvider.of<BookmarkListCubit>(context);

    return PopupMenuButton(
      icon: const Icon(Icons.more_vert_rounded),
      clipBehavior: Clip.hardEdge,
      itemBuilder: (BuildContext context) {
        final state = cubit.state;
        List<PopupMenuEntry<dynamic>> entries = [];

        // Edit mode button
        if (state.code == LoadingStateCode.loaded && !state.isSelecting) {
          entries.addAll([
            PopupMenuItem(
              onTap: () => cubit.setSelecting(true),
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                dense: true,
                leading: const SizedBox(width: 24.0),
                title: Text(appLocalizations.generalSelect),
                trailing: const Icon(Icons.check_circle_outline_rounded),
              ),
            ),
            const PopupMenuDivider(),
          ]);
        }

        // The sorting button
        final sortMap = {
          SortOrderCode.name: appLocalizations.bookmarkListSortName,
          SortOrderCode.savedTime: appLocalizations.bookmarkListSortSavedTime,
        };

        for (final entry in sortMap.entries) {
          final isSelected = state.sortOrder == entry.key;
          final isAscending = state.isAscending;
          entries.add(PopupMenuItem(
            onTap: () {
              cubit.setListOrder(
                sortOrder: !isSelected ? entry.key : null,
                isAscending: isSelected ? !state.isAscending : null,
              );
            },
            child: CommonPopupMenuSortListTile(
              isSelected: isSelected,
              isAscending: isAscending,
              title: entry.value,
            ),
          ));
        }

        return entries;
      },
    );
  }
}
