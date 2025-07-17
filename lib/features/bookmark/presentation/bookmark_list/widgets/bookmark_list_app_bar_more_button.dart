part of '../../../bookmark_service.dart';

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
      PopupMenuUtils.addSection(entries, <PopupMenuItem<void>>[
        SharedList.buildSelectionModeButton(context: context, cubit: cubit),
      ]);
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

    // List View Changing Section
    PopupMenuUtils.addSection(
        entries,
        SharedList.buildViewMenu(
          // TODO(kai): Translations.
          titleList: <String>[
            'Grid',
            'List',
          ],
          typeList: <SharedListType>[
            SharedListType.grid,
            SharedListType.list,
          ],
          iconList: <IconData>[
            Icons.grid_view_rounded,
            Icons.list_rounded,
          ],
          cubit: cubit,
        ));

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
}
