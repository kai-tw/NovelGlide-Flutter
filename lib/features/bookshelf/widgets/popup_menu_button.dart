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
      itemBuilder: (BuildContext context) {
        List<PopupMenuEntry<dynamic>> entries = [];

        final Map<SortOrderCode, String> sortMap = {
          SortOrderCode.name: appLocalizations.bookshelfSortName,
          SortOrderCode.modifiedDate:
              appLocalizations.bookshelfSortLastModified,
        };

        for (MapEntry<SortOrderCode, String> entry in sortMap.entries) {
          bool isSelected = cubit.state.sortOrder == entry.key;
          entries.add(
            PopupMenuItem(
              onTap: () => isSelected
                  ? cubit.setListOrder(isAscending: !cubit.state.isAscending)
                  : cubit.setListOrder(sortOrder: entry.key),
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                dense: true,
                leading: isSelected
                    ? const Icon(Icons.check_rounded)
                    : const SizedBox(width: 24.0),
                title: Text(entry.value),
                trailing: isSelected
                    ? Icon(cubit.state.isAscending
                        ? CupertinoIcons.chevron_up
                        : CupertinoIcons.chevron_down)
                    : const SizedBox(width: 24.0),
              ),
            ),
          );
        }

        /// Edit mode
        if (cubit.state.code == LoadingStateCode.loaded &&
            !cubit.state.isSelecting) {
          entries.insertAll(0, [
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

        return entries;
      },
    );
  }
}