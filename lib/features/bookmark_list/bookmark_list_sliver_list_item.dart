import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../shared/bookmark_object.dart';
import '../reader/reader.dart';
import 'bloc/bookmark_list_bloc.dart';

class BookmarkListSliverListItem extends StatelessWidget {
  const BookmarkListSliverListItem(this._bookmarkObject, {super.key});

  final BookmarkObject _bookmarkObject;

  @override
  Widget build(BuildContext context) {
    final BookmarkListCubit cubit = BlocProvider.of<BookmarkListCubit>(context);
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final String bookName = _bookmarkObject.bookName;
    final int chapterNumber = _bookmarkObject.chapterNumber;
    final int daysPassed = _bookmarkObject.daysPassed;
    String savedTimeString = "";

    switch (daysPassed) {
      case 0:
        savedTimeString = appLocalizations.last_save_days_today;
        break;
      case 1:
        savedTimeString = appLocalizations.last_save_days_yesterday;
        break;
      default:
        savedTimeString = appLocalizations.last_save_days_others(daysPassed);
    }

    savedTimeString = appLocalizations.last_save_days(savedTimeString);

    return Container(
      margin: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16.0)),
      ),
      clipBehavior: Clip.hardEdge,
      child: Slidable(
        groupTag: "BookmarkSliverListItem",
        endActionPane: ActionPane(
          extentRatio: 0.2,
          motion: const DrawerMotion(),
          children: [
            SlidableAction(
              onPressed: (_) {
                _bookmarkObject.clear();
                cubit.refresh();
              },
              backgroundColor: Theme.of(context).colorScheme.error,
              foregroundColor: Theme.of(context).colorScheme.onError,
              icon: Icons.delete_outline_rounded,
            ),
          ],
        ),
        child: GestureDetector(
          onTap: () => Navigator.of(context).push(_navigateToReader(bookName, chapterNumber)).then((_) => cubit.refresh()),
          child: Row(
            children: [
              Icon(
                Icons.bookmark_rounded,
                color: Theme.of(context).colorScheme.onBackground,
              ),
              Expanded(
                child: Container(
                  color: Theme.of(context).colorScheme.background,
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        bookName,
                        style: const TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                      Text(
                        appLocalizations.chapter_label(chapterNumber),
                        style: const TextStyle(
                          fontSize: 14.0,
                        ),
                      ),
                      Text(
                        savedTimeString,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Route _navigateToReader(String bookName, int chapterNumber) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => ReaderWidget(bookName, chapterNumber),
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
