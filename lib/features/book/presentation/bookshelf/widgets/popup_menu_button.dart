part of '../bookshelf.dart';

class _PopupMenuButton extends StatelessWidget {
  const _PopupMenuButton();

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final BookshelfCubit cubit = BlocProvider.of<BookshelfCubit>(context);
    return PopupMenuButton<void>(
      icon: const Icon(Icons.more_vert_rounded),
      clipBehavior: Clip.hardEdge,
      itemBuilder: (BuildContext context) {
        final bool isLoaded = cubit.state.code == LoadingStateCode.loaded;
        final List<PopupMenuEntry<void>> entries = <PopupMenuEntry<void>>[];

        /// Selecting mode
        if (isLoaded && !cubit.state.isSelecting) {
          entries.addAll(<PopupMenuEntry<void>>[
            PopupMenuItem<void>(
              onTap: () => cubit.isSelecting = true,
              child: const CommonListSelectModeButton(),
            ),
            const PopupMenuDivider(),
          ]);
        }

        /// Sorting Section
        final Map<SortOrderCode, String> sortMap = <SortOrderCode, String>{
          SortOrderCode.name: appLocalizations.bookshelfSortName,
          SortOrderCode.modifiedDate:
              appLocalizations.bookshelfSortLastModified,
        };

        for (final MapEntry<SortOrderCode, String> entry in sortMap.entries) {
          final bool isSelected = cubit.state.sortOrder == entry.key;
          entries.add(
            PopupMenuItem<void>(
              onTap: () => isSelected
                  ? cubit.setListOrder(isAscending: !cubit.state.isAscending)
                  : cubit.setListOrder(sortOrder: entry.key),
              child: CommonListSortButton(
                isSelected: isSelected,
                isAscending: cubit.state.isAscending,
                title: entry.value,
              ),
            ),
          );
        }

        /// Operation Section
        if (isLoaded && cubit.state.isSelecting) {
          entries.addAll(<PopupMenuEntry<void>>[
            const PopupMenuDivider(),
            PopupMenuItem<void>(
              onTap: () {
                Navigator.of(context).push(RouteUtils.pushRoute(
                  CollectionAddBookScaffold(
                    dataSet: cubit.state.selectedSet,
                  ),
                ));
              },
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                dense: true,
                leading: const Icon(Icons.collections_bookmark_rounded),
                title: Text(appLocalizations.addToCollection),
              ),
            ),
            PopupMenuItem<void>(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return CommonDeleteDialog(
                      onDelete: () => cubit.deleteSelectedBooks(),
                    );
                  },
                );
              },
              enabled: cubit.state.selectedSet.isNotEmpty,
              child: const CommonListDeleteButton(),
            ),
          ]);
        }

        return entries;
      },
    );
  }
}
