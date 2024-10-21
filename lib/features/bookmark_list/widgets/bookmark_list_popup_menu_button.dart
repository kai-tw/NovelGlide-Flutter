import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../enum/loading_state_code.dart';
import '../../../enum/sort_order_code.dart';
import '../bloc/bookmark_list_bloc.dart';

class BookmarkListPopupMenuButton extends StatelessWidget {
  const BookmarkListPopupMenuButton({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final cubit = BlocProvider.of<BookmarkListCubit>(context);
    final state = cubit.state;

    return PopupMenuButton(
      icon: const Icon(Icons.more_vert_rounded),
      clipBehavior: Clip.hardEdge,
      itemBuilder: (BuildContext context) {
        List<PopupMenuEntry<dynamic>> entries = [];

        // Edit mode button
        if (state.code == LoadingStateCode.loaded && !state.isSelecting) {
          entries.addAll([
            PopupMenuItem(
              onTap: () => cubit.isSelecting = true,
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
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              dense: true,
              leading: isSelected
                  ? const Icon(Icons.check_rounded)
                  : const SizedBox(width: 24.0),
              title: Text(entry.value),
              trailing: isSelected
                  ? Icon(isAscending
                      ? CupertinoIcons.chevron_up
                      : CupertinoIcons.chevron_down)
                  : const SizedBox(width: 24.0),
            ),
          ));
        }

        return entries;
      },
    );
  }
}
