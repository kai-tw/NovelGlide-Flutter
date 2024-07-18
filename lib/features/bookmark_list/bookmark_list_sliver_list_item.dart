import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../data/bookmark_data.dart';
import '../reader/reader.dart';
import 'bloc/bookmark_list_bloc.dart';
import 'bookmark_list_draggable_bookmark.dart';

class BookmarkListSliverListItem extends StatelessWidget {
  const BookmarkListSliverListItem(this._bookmarkObject, {super.key});

  final BookmarkData _bookmarkObject;

  @override
  Widget build(BuildContext context) {
    final BookmarkListCubit cubit = BlocProvider.of<BookmarkListCubit>(context);

    return InkWell(
      borderRadius: BorderRadius.circular(24.0),
      onTap: () => Navigator.of(context)
          .push(MaterialPageRoute(
            builder: (context) =>
                ReaderWidget(_bookmarkObject.bookName, _bookmarkObject.chapterNumber, isAutoJump: true),
          ))
          .then((_) => cubit.refresh()),
      child: Semantics(
        label: AppLocalizations.of(context)!.accessibilityBookmarkListItem,
        onTapHint: AppLocalizations.of(context)!.accessibilityBookmarkListItemOnTap,
        onLongPressHint: AppLocalizations.of(context)!.accessibilityBookmarkListItemOnLongPress,
        child: BookmarkListDraggableBookmark(_bookmarkObject),
      ),
    );
  }
}
