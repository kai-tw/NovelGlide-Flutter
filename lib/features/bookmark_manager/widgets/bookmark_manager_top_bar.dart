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
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainer,
            borderRadius: BorderRadius.circular(24.0),
          ),
          child: InkWell(
            onTap: () => _onTap(cubit),
            child: Row(
              children: [
                Checkbox(
                  tristate: true,
                  value: state.bookmarkList.isNotEmpty && state.bookmarkList.length == state.selectedBookmarks.length
                      ? true
                      : state.selectedBookmarks.isNotEmpty
                          ? null
                          : false,
                  onChanged: (_) => _onTap(cubit),
                  semanticLabel: AppLocalizations.of(context)!.accessibilitySelectAllCheckbox,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text(
                      AppLocalizations.of(context)!.selectAll,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ),
              ],
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
