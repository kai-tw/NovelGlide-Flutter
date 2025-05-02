part of '../bookmark_list.dart';

class _PopupMenuButton extends StatelessWidget {
  const _PopupMenuButton();

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final BookmarkListCubit cubit = BlocProvider.of<BookmarkListCubit>(context);

    return PopupMenuButton<void>(
      icon: const Icon(Icons.more_vert_rounded),
      clipBehavior: Clip.hardEdge,
      itemBuilder: (BuildContext context) {
        final BookmarkListState state = cubit.state;
        final bool isLoaded = state.code == LoadingStateCode.loaded;
        final List<PopupMenuEntry<void>> entries = <PopupMenuEntry<void>>[];

        /// Selecting mode
        if (isLoaded && !state.isSelecting) {
          entries.addAll(<PopupMenuEntry<void>>[
            PopupMenuItem<void>(
                onTap: () => cubit.isSelecting = false,
                child: const CommonListSelectModeButton()),
            const PopupMenuDivider(),
          ]);
        }

        /// Sorting Section
        final Map<SortOrderCode, String> sortMap = <SortOrderCode, String>{
          SortOrderCode.name: appLocalizations.bookmarkListSortName,
          SortOrderCode.savedTime: appLocalizations.bookmarkListSortSavedTime,
        };

        for (final MapEntry<SortOrderCode, String> entry in sortMap.entries) {
          final bool isSelected = state.sortOrder == entry.key;
          final bool isAscending = state.isAscending;
          entries.add(PopupMenuItem<void>(
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
          entries.addAll(<PopupMenuEntry<void>>[
            const PopupMenuDivider(),
            PopupMenuItem<void>(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return CommonDeleteDialog(
                      onDelete: () => cubit.deleteSelectedBookmarks(),
                    );
                  },
                );
              },
              enabled: state.selectedSet.isNotEmpty,
              child: const CommonListDeleteButton(),
            ),
          ]);
        }

        return entries;
      },
    );
  }
}
