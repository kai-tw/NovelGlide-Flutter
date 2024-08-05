import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../bloc/bookmark_manager_bloc.dart';

class BookmarkManagerTopBar extends StatelessWidget {
  const BookmarkManagerTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    final BookmarkManagerCubit cubit = BlocProvider.of<BookmarkManagerCubit>(context);
    return BlocBuilder<BookmarkManagerCubit, BookmarkManagerState>(
      buildWhen: (previous, current) =>
          previous.selectedBookmarks != current.selectedBookmarks || previous.bookmarkList != current.bookmarkList,
      builder: (BuildContext context, BookmarkManagerState state) {
        bool? checkBoxValue;

        if (state.bookmarkList.isNotEmpty && state.bookmarkList.length == state.selectedBookmarks.length) {
          checkBoxValue = true;
        } else if (state.selectedBookmarks.isNotEmpty) {
          checkBoxValue = null;
        } else {
          checkBoxValue = false;
        }

        return GestureDetector(
          onTap: () => _onTap(cubit),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainer,
              borderRadius: BorderRadius.circular(24.0),
            ),
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Checkbox(
                tristate: true,
                value: checkBoxValue,
                onChanged: (_) => _onTap(cubit),
                semanticLabel: AppLocalizations.of(context)!.accessibilitySelectAllCheckbox,
              ),
              title: Text(AppLocalizations.of(context)!.selectAll),
            ),
          ),
        );
      },
    );
  }

  void _onTap(BookmarkManagerCubit cubit) {
    if (cubit.state.selectedBookmarks.isEmpty) {
      cubit.selectAllBookmarks();
    } else {
      cubit.deselectAllBookmarks();
    }
  }
}
