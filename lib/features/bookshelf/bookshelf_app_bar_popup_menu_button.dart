import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../data/loading_state_code.dart';
import 'bloc/bookshelf_bloc.dart';

class BookshelfAppBarPopupMenuButton extends StatelessWidget {
  const BookshelfAppBarPopupMenuButton({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final BookshelfCubit cubit = BlocProvider.of<BookshelfCubit>(context);
    return PopupMenuButton(
      icon: const Icon(Icons.more_vert_rounded),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
      clipBehavior: Clip.hardEdge,
      itemBuilder: (BuildContext context) {
        List<PopupMenuEntry<dynamic>> entries = [];

        final Map<BookshelfSortOrder, String> sortMap = {
          BookshelfSortOrder.name: appLocalizations.bookshelfSortName,
          BookshelfSortOrder.modifiedDate: appLocalizations.bookshelfSortLastModified,
        };

        for (MapEntry<BookshelfSortOrder, String> entry in sortMap.entries) {
          bool isSelected = cubit.state.sortOrder == entry.key;
          entries.add(
            PopupMenuItem(
              onTap: () => isSelected
                  ? cubit.setListOrder(isAscending: !cubit.state.isAscending)
                  : cubit.setListOrder(sortOrder: entry.key),
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
                title: Text(appLocalizations.bookshelfSelect),
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
