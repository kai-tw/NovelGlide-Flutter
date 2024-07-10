import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../data/bookmark_data.dart';
import '../homepage/bloc/homepage_bloc.dart';
import 'bloc/bookmark_list_bloc.dart';
import 'bookmark_list_bookmark_widget.dart';

class BookmarkListDraggableBookmark extends StatelessWidget {
  final BookmarkData _bookmarkObject;

  const BookmarkListDraggableBookmark(this._bookmarkObject, {super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final BookmarkListCubit cubit = BlocProvider.of<BookmarkListCubit>(context);
    final HomepageCubit homepageCubit = BlocProvider.of<HomepageCubit>(context);

    return LayoutBuilder(builder: (context, constraints) {
      return LongPressDraggable(
        onDragStarted: () => homepageCubit.setDragging(true),
        onDragEnd: (_) => homepageCubit.setDragging(false),
        onDragCompleted: () {
          try {
            _bookmarkObject.clear();
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(appLocalizations.deleteBookmarkFailed),
              ),
            );
            return;
          }

          cubit.refresh();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(appLocalizations.deleteBookmarkSuccessfully),
            ),
          );
        },
        data: _bookmarkObject,
        feedback: Opacity(
          opacity: 0.7,
          child: _createBookmarkWidget(context, constraints),
        ),
        childWhenDragging: Opacity(
          opacity: 0,
          child: _createBookmarkWidget(context, constraints),
        ),
        child: _createBookmarkWidget(context, constraints),
      );
    });
  }

  Widget _createBookmarkWidget(BuildContext context, BoxConstraints constraints) {
    return Container(
      width: constraints.maxWidth,
      padding: const EdgeInsets.all(16.0),
      color: Colors.transparent,
      child: BookmarkListBookmarkWidget(_bookmarkObject),
    );
  }
}
