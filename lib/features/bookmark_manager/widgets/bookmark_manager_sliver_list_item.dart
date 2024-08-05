import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../data/bookmark_data.dart';
import '../../common_components/bookmark_widget.dart';
import '../bloc/bookmark_manager_bloc.dart';

class BookmarkManagerSliverListItem extends StatelessWidget {
  final BookmarkData bookmarkData;

  const BookmarkManagerSliverListItem({super.key, required this.bookmarkData});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final BookmarkManagerCubit cubit = BlocProvider.of<BookmarkManagerCubit>(context);
    return BlocBuilder<BookmarkManagerCubit, BookmarkManagerState>(
      builder: (context, state) {
        final bool isSelected = state.selectedBookmarks.contains(bookmarkData.bookName);
        return Semantics(
          label: appLocalizations.bookmarkManagerAccessibilitySelectItem,
          child: GestureDetector(
            onTap: () => _onTap(cubit, !cubit.state.selectedBookmarks.contains(bookmarkData.bookName)),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              decoration: BoxDecoration(
                color: isSelected
                    ? Theme.of(context).colorScheme.errorContainer
                    : Theme.of(context).colorScheme.surfaceContainer,
                borderRadius: BorderRadius.circular(24.0),
              ),
              child: BookmarkWidget(
                bookmarkData,
                color: isSelected ? Theme.of(context).colorScheme.onErrorContainer : null,
                leading: Checkbox(
                  value: isSelected,
                  onChanged: (value) => _onTap(cubit, value),
                  activeColor: Colors.transparent,
                  checkColor: Theme.of(context).colorScheme.onErrorContainer,
                  semanticLabel: appLocalizations.accessibilityBookmarkManagerCheckbox,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _onTap(BookmarkManagerCubit cubit, bool? value) {
    if (value == true) {
      cubit.selectBookmark(bookmarkData.bookName);
    } else {
      cubit.deselectBookmark(bookmarkData.bookName);
    }
  }
}
