import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../common_components/common_slidable_action/common_slidable_action_delete.dart';
import '../reader/reader.dart';
import 'bloc/toc_bloc.dart';

class TOCSliverChapterListItem extends StatelessWidget {
  const TOCSliverChapterListItem({super.key, this.title, required this.chapterNumber});

  final String? title;
  final int chapterNumber;

  @override
  Widget build(BuildContext context) {
    final TOCCubit cubit = BlocProvider.of<TOCCubit>(context);
    final String localizedOrdinalNum = AppLocalizations.of(context)!.chapterLabelFunction(chapterNumber);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
        ),
        clipBehavior: Clip.hardEdge,
        child: Slidable(
          groupTag: "TOCSliverChapterList",
          endActionPane: ActionPane(
            extentRatio: 0.3,
            motion: const DrawerMotion(),
            children: [
              CommonSlidableActionDelete(onDelete: () => cubit.deleteChapter(chapterNumber)),
            ],
          ),
          child: SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: () => Navigator.of(context).push(_navigateToReader(cubit.bookObject.name, chapterNumber)),
              style: TextButton.styleFrom(
                alignment: Alignment.centerLeft,
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                foregroundColor: Theme.of(context).colorScheme.onSurface,
              ),
              child: Text(
                localizedOrdinalNum + (title != null && title!.isNotEmpty ? " - $title" : ""),
                textAlign: TextAlign.left,
              ),
            ),
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
