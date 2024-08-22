import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../data/book_data.dart';
import '../../data/bookmark_data.dart';
import '../common_components/bookmark_widget.dart';
import '../reader/reader.dart';
import 'bloc/bookmark_list_bloc.dart';
import 'bookmark_list_draggable_bookmark.dart';

class BookmarkListSliverListItem extends StatelessWidget {
  const BookmarkListSliverListItem(this._bookmarkData, {super.key});

  final BookmarkData _bookmarkData;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final BookmarkListCubit cubit = BlocProvider.of<BookmarkListCubit>(context);

    return InkWell(
      borderRadius: BorderRadius.circular(24.0),
      onTap: () async {
        if (cubit.state.isSelecting) {
          if (cubit.state.selectedBookmarks.contains(_bookmarkData.bookPath)) {
            cubit.deselectBookmark(_bookmarkData.bookPath);
          } else {
            cubit.selectBookmark(_bookmarkData.bookPath);
          }
        } else {
          final BookData bookData = await BookData.fromPath(_bookmarkData.bookPath);
          if (context.mounted) {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => ReaderWidget(bookData, isAutoJump: true)))
                .then((_) => cubit.refresh());
          }
        }
      },
      child: BlocBuilder<BookmarkListCubit, BookmarkListState>(
        buildWhen: (previous, current) =>
            previous.isSelecting != current.isSelecting || previous.selectedBookmarks != current.selectedBookmarks,
        builder: (BuildContext context, BookmarkListState state) {
          if (state.isSelecting) {
            final bool isSelected = state.selectedBookmarks.contains(_bookmarkData.bookPath);
            return Semantics(
              label: appLocalizations.bookmarkListAccessibilityItem,
              onTapHint: appLocalizations.bookmarkListAccessibilitySelectOnTap,
              child: BookmarkWidget(
                _bookmarkData,
                trailing: Checkbox(
                  value: isSelected,
                  activeColor: Colors.transparent,
                  checkColor: Theme.of(context).colorScheme.onErrorContainer,
                  onChanged: (bool? value) {
                    if (value == true) {
                      cubit.selectBookmark(_bookmarkData.bookPath);
                    } else {
                      cubit.deselectBookmark(_bookmarkData.bookPath);
                    }
                  },
                  semanticLabel: appLocalizations.bookmarkListAccessibilitySelectItem,
                ),
                backgroundColor: isSelected ? Theme.of(context).colorScheme.errorContainer : null,
                color: isSelected ? Theme.of(context).colorScheme.onErrorContainer : null,
              ),
            );
          } else {
            return Semantics(
              label: appLocalizations.bookmarkListAccessibilityItem,
              onTapHint: appLocalizations.bookmarkListAccessibilityOnTap,
              onLongPressHint: appLocalizations.bookmarkListAccessibilityOnLongPress,
              child: BookmarkListDraggableBookmark(_bookmarkData),
            );
          }
        },
      ),
    );
  }
}
