import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../enum/loading_state_code.dart';
import '../../enum/sort_order_code.dart';
import 'bloc/bookmark_list_bloc.dart';

class BookmarkListPopupMenu extends StatelessWidget {
  static const _blankIcon = SizedBox(width: 24.0);

  const BookmarkListPopupMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    final cubit = BlocProvider.of<BookmarkListCubit>(context);
    return PopupMenuButton(
      icon: const Icon(Icons.more_vert_rounded),
      clipBehavior: Clip.hardEdge,
      itemBuilder: (BuildContext context) {
        List<PopupMenuEntry<dynamic>> entries = [];

        // Edit mode button
        if (cubit.state.code == LoadingStateCode.loaded &&
            !cubit.state.isSelecting) {
          entries.addAll([
            _buildEditButton(appLocalizations, cubit),
            const PopupMenuDivider(),
          ]);
        }

        // The sorting button
        final sortMap = {
          SortOrderCode.name: appLocalizations?.bookmarkListSortName ?? 'Name',
          SortOrderCode.savedTime:
              appLocalizations?.bookmarkListSortSavedTime ?? 'Saved Time',
        };

        for (MapEntry<SortOrderCode, String> entry in sortMap.entries) {
          entries.add(_buildSortingButton(entry, cubit));
        }

        return entries;
      },
    );
  }

  PopupMenuEntry<dynamic> _buildEditButton(
    AppLocalizations? appLocalizations,
    BookmarkListCubit cubit,
  ) {
    return PopupMenuItem(
      onTap: () => cubit.isSelecting = true,
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        dense: true,
        leading: _blankIcon,
        title: Text(appLocalizations?.bookmarkListSelect ?? 'Edit'),
        trailing: const Icon(Icons.check_circle_outline_rounded),
      ),
    );
  }

  PopupMenuEntry<dynamic> _buildSortingButton(
    MapEntry<SortOrderCode, String> entry,
    BookmarkListCubit cubit,
  ) {
    final isSelected = cubit.state.sortOrder == entry.key;
    final isAscending = cubit.state.isAscending;
    return PopupMenuItem(
      onTap: () {
        cubit.setListOrder(
          sortOrder: !isSelected ? entry.key : null,
          isAscending: isSelected ? !cubit.state.isAscending : null,
        );
      },
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        dense: true,
        leading: isSelected ? const Icon(Icons.check_rounded) : _blankIcon,
        title: Text(entry.value),
        trailing: isSelected
            ? Icon(isAscending
                ? CupertinoIcons.chevron_up
                : CupertinoIcons.chevron_down)
            : _blankIcon,
      ),
    );
  }
}
