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
        final isLoaded = state.code == LoadingStateCode.loaded;
        List<PopupMenuEntry<dynamic>> entries = [];

        /// Selecting mode
        if (isLoaded && !state.isSelecting) {
          entries.addAll([
            PopupMenuItem(
                onTap: () => cubit.setSelecting(true),
                child: const CommonListSelectModeButton()),
            const PopupMenuDivider(),
          ]);
        }

        /// Sorting Section
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
                isAscending: isSelected ? !isAscending : null,
              );
            },
            child: CommonListSortButton(
              isSelected: isSelected,
              isAscending: isAscending,
              title: entry.value,
            ),
          ));
        }

        /// Operation Section
        if (isLoaded && state.isSelecting) {
          entries.addAll([
            const PopupMenuDivider(),
            CommonListDeleteButton.helper(
              context: context,
              onDelete: () => cubit.deleteSelectedBookmarks(),
              enabled: state.selectedSet.isNotEmpty,
            ),
          ]);
        }

        return entries;
      },
    );
  }
}
