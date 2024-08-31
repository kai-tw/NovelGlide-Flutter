import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../data/loading_state_code.dart';
import 'bloc/bookmark_list_bloc.dart';

class BookmarkListAppBarPopupMenuButton extends StatelessWidget {
  const BookmarkListAppBarPopupMenuButton({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final BookmarkListCubit cubit = BlocProvider.of<BookmarkListCubit>(context);
    return PopupMenuButton(
      icon: const Icon(Icons.more_vert_rounded),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
      clipBehavior: Clip.hardEdge,
      itemBuilder: (BuildContext context) {
        List<PopupMenuEntry<dynamic>> entries = [];

        final Map<BookmarkListSortOrder, String> sortMap = {
          BookmarkListSortOrder.name: appLocalizations.bookmarkListSortName,
          BookmarkListSortOrder.savedTime: appLocalizations.bookmarkListSortSavedTime,
        };

        for (MapEntry<BookmarkListSortOrder, String> entry in sortMap.entries) {
          bool isSelected = cubit.state.sortOrder == entry.key;
          entries.add(
            PopupMenuItem(
              onTap: () => isSelected ? cubit.setAscending(!cubit.state.isAscending) : cubit.setSortOrder(entry.key),
              child: SizedBox(
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  dense: true,
                  leading: isSelected ? const Icon(Icons.check_rounded) : const SizedBox(width: 24.0),
                  title: Text(entry.value),
                  trailing: isSelected
                      ? cubit.state.isAscending
                      ? const Icon(CupertinoIcons.chevron_up)
                      : const Icon(CupertinoIcons.chevron_down)
                      : const SizedBox(width: 24.0),
                ),
              ),
            ),
          );
        }

        /// Edit mode
        if (cubit.state.code == LoadingStateCode.loaded && !cubit.state.isSelecting) {
          entries.insertAll(0, [
            PopupMenuItem(
              onTap: () => cubit.setSelecting(true),
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                dense: true,
                leading: const SizedBox(width: 24.0),
                title: Text(appLocalizations.bookmarkListSelect),
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
