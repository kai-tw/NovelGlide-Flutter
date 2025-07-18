part of '../bookmark_list.dart';

class BookmarkListAppBarMoreButton extends StatelessWidget {
  const BookmarkListAppBarMoreButton({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<void>(
      clipBehavior: Clip.hardEdge,
      itemBuilder: _itemBuilder,
    );
  }

  List<PopupMenuEntry<void>> _itemBuilder(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final BookmarkListCubit cubit = BlocProvider.of<BookmarkListCubit>(context);
    final List<PopupMenuEntry<void>> entries = <PopupMenuEntry<void>>[];

    // Selecting mode button
    if (cubit.state.code.isLoaded &&
        !cubit.state.isSelecting &&
        cubit.state.dataList.isNotEmpty) {
      PopupMenuUtils.addSection(entries,
          SharedListSelectModeTile.itemBuilder<BookmarkListCubit>(context));
    }

    // Sorting Section
    PopupMenuUtils.addSection(
      entries,
      SharedList.buildSortMenu(
        titleList: <String>[
          appLocalizations.bookmarkListSortName,
          appLocalizations.bookmarkListSortSavedTime,
        ],
        sortOrderList: <SortOrderCode>[
          SortOrderCode.name,
          SortOrderCode.savedTime,
        ],
        cubit: cubit,
      ),
    );

    // Operation Section
    if (cubit.state.code.isLoaded &&
        cubit.state.isSelecting &&
        cubit.state.selectedSet.isNotEmpty) {
      PopupMenuUtils.addSection(entries, <PopupMenuEntry<void>>[
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
          child: const SharedListDeleteButton(),
        ),
      ]);
    }

    return entries;
  }

  /// ==========================================================
  /// Click Handler

  /// Tap on sorting button
  void _onTapSorting(BuildContext context, SortOrderCode sortOrder) {
    final BookmarkListCubit cubit = BlocProvider.of<BookmarkListCubit>(context);
    if (cubit.state.sortOrder == sortOrder) {
      cubit.setListOrder(isAscending: !cubit.state.isAscending);
    } else {
      cubit.setListOrder(sortOrder: sortOrder);
    }
  }
}
