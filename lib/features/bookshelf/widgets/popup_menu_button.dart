part of '../bookshelf.dart';

class _PopupMenuButton extends StatelessWidget {
  const _PopupMenuButton();

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final cubit = BlocProvider.of<BookshelfCubit>(context);
    return PopupMenuButton(
      icon: const Icon(Icons.more_vert_rounded),
      clipBehavior: Clip.hardEdge,
      itemBuilder: (context) {
        final isLoaded = cubit.state.code == LoadingStateCode.loaded;
        List<PopupMenuEntry<dynamic>> entries = [];

        /// Selecting mode
        if (isLoaded && !cubit.state.isSelecting) {
          entries.addAll([
            PopupMenuItem(
              onTap: () => cubit.setSelecting(true),
              child: const CommonListSelectModeButton(),
            ),
            const PopupMenuDivider(),
          ]);
        }

        /// Sorting Section
        final sortMap = {
          SortOrderCode.name: appLocalizations.bookshelfSortName,
          SortOrderCode.modifiedDate:
              appLocalizations.bookshelfSortLastModified,
        };

        for (final entry in sortMap.entries) {
          final isSelected = cubit.state.sortOrder == entry.key;
          entries.add(
            PopupMenuItem(
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
          entries.addAll([
            const PopupMenuDivider(),
            PopupMenuItem(
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
            PopupMenuItem(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
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
