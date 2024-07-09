import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../data/bookmark_data.dart';
import '../common_components/common_slidable_action/common_slidable_action_delete.dart';
import '../homepage/bloc/homepage_bloc.dart';
import '../reader/reader.dart';
import 'bloc/bookmark_list_bloc.dart';
import 'bookmark_list_bookmark_widget.dart';

class BookmarkListSliverListItem extends StatelessWidget {
  const BookmarkListSliverListItem(this._bookmarkObject, {super.key});

  final BookmarkData _bookmarkObject;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final BookmarkListCubit cubit = BlocProvider.of<BookmarkListCubit>(context);
    final HomepageCubit homepageCubit = BlocProvider.of<HomepageCubit>(context);

    return GestureDetector(
      onTap: () => Navigator.of(context).push(_navigateToReader()).then((_) => cubit.refresh()),
      child: LayoutBuilder(
          builder: (context, constraints) {
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
              child: Slidable(
                groupTag: "BookmarkSliverListItem",
                endActionPane: ActionPane(
                  extentRatio: 0.25,
                  motion: const DrawerMotion(),
                  children: [
                    CommonSlidableActionDelete(onDelete: () {
                      _bookmarkObject.clear();
                      cubit.refresh();
                    }),
                  ],
                ),
                child: _createBookmarkWidget(context, constraints),
              ),
            );
          }
      ),
    );
  }

  Widget _createBookmarkWidget(BuildContext context, BoxConstraints constraints) {
    return Container(
      width: constraints.maxWidth,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(24.0),
      ),
      child: BookmarkListBookmarkWidget(_bookmarkObject),
    );
  }

  Route _navigateToReader() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          ReaderWidget(_bookmarkObject.bookName, _bookmarkObject.chapterNumber, isAutoJump: true),
      transitionDuration: const Duration(milliseconds: 300),
      reverseTransitionDuration: const Duration(milliseconds: 300),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
              parent: animation,
              curve: Curves.easeInOut,
            ),
          ),
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(
                parent: animation,
                curve: Curves.easeInOut,
              ),
            ),
            child: child,
          ),
        );
      },
    );
  }
}
