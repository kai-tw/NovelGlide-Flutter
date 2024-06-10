import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../data/bookmark_data.dart';
import '../common_components/common_slidable_action/common_slidable_action_delete.dart';
import '../reader/reader.dart';
import 'bloc/bookmark_list_bloc.dart';

class BookmarkListSliverListItem extends StatelessWidget {
  const BookmarkListSliverListItem(this._bookmarkObject, {super.key});

  final BookmarkData _bookmarkObject;

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
        savedTimeString = appLocalizations.savedTimeToday;
        break;
      case 1:
        savedTimeString = appLocalizations.savedTimeYesterday;
        break;
      default:
        savedTimeString = appLocalizations.savedTimeOthersFunction(daysPassed);
    }

    savedTimeString = appLocalizations.savedTimeFunction(savedTimeString);

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
            CommonSlidableActionDelete(onDelete: () {
              _bookmarkObject.clear();
              cubit.refresh();
            }),
          ],
        ),
        child: GestureDetector(
          onTap: () =>
              Navigator.of(context).push(_navigateToReader(bookName, chapterNumber)).then((_) => cubit.refresh()),
          child: Row(
            children: [
              Icon(
                Icons.bookmark_rounded,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              Expanded(
                child: Container(
                  color: Theme.of(context).colorScheme.surface,
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
                        appLocalizations.chapterLabelFunction(chapterNumber),
                        style: const TextStyle(
                          fontSize: 14.0,
                        ),
                      ),
                      Text(
                        savedTimeString,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
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
      pageBuilder: (context, animation, secondaryAnimation) => ReaderWidget(bookName, chapterNumber, isAutoJump: true),
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
