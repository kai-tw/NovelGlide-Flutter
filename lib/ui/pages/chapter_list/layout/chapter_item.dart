import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:novelglide/ui/motion/motion_listener.dart';
import 'package:novelglide/ui/motion/route_slide_transition.dart';
import 'package:novelglide/ui/pages/chapter_list/bloc/chapter_list_bloc.dart';
import 'package:novelglide/ui/pages/chapter_list/layout/chapter_list.dart';
import 'package:novelglide/ui/pages/book_form/bloc/form_bloc.dart';
import 'package:novelglide/ui/pages/book_form/layout/main.dart';
import 'package:novelglide/ui/pages/main/bloc/library_bloc.dart';

class ChapterItem extends StatelessWidget {
  const ChapterItem(this.chapterName, {super.key});

  final String chapterName;

  @override
  Widget build(BuildContext context) {
    LibraryBookListState state = BlocProvider.of<LibraryBookListCubit>(context).state;
    bool isSelected = state.selectedBooks.contains(chapterName);
    bool isSlideOpen = false;
    double borderRadius = 16.0;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      clipBehavior: Clip.hardEdge,
      child: Slidable(
        groupTag: 'LibraryBookList',
        closeOnScroll: false,
        endActionPane: ActionPane(
          extentRatio: 0.4,
          motion: MotionListener(
            onOpenEnd: () {
              // BlocProvider.of<ChapterListCubit>(context).addSlide(state, chapterName);
              isSlideOpen = true;
            },
            onClose: () {
              // BlocProvider.of<ChapterListCubit>(context).removeSlide(state, chapterName);
              isSlideOpen = false;
            },
            motionWidget: const DrawerMotion(),
          ),
          children: [
            SlidableAction(
              padding: const EdgeInsets.all(16.0),
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Theme.of(context).colorScheme.onPrimary,
              icon: Icons.edit_rounded,
              onPressed: (_) {
                Navigator.of(context).push(_routeToEditPage()).then((_) {
                  BlocProvider.of<LibraryBookListCubit>(context).refresh();
                });
              },
            ),
            SlidableAction(
              padding: const EdgeInsets.all(16.0),
              backgroundColor: Theme.of(context).colorScheme.error,
              foregroundColor: Theme.of(context).colorScheme.onError,
              icon: Icons.delete_outline_rounded,
              onPressed: (_) {
                _showConfirmDialog(context).then((isDelete) {
                  if (isDelete != null && isDelete) {
                    BlocProvider.of<LibraryBookListCubit>(context).deleteBook(state, chapterName);
                  }
                });
              },
            ),
          ],
        ),
        child: GestureDetector(
          child: AnimatedContainer(
            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
            width: double.infinity,
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              color: isSelected ? Theme.of(context).colorScheme.onTertiary : Colors.transparent,
            ),
            child: SizedBox(
              width: double.infinity,
              child: Row(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.only(right: 12.0),
                    width: state.code == LibraryBookListStateCode.selecting ? 20.0 : 0.0,
                    child: Icon(
                      isSelected ? Icons.check : Icons.check_box_outline_blank_rounded,
                      size: state.code == LibraryBookListStateCode.selecting ? 20.0 : 0.0,
                    ),
                  ),
                  Expanded(child: Text(chapterName)),
                ],
              ),
            ),
          ),

          /// Actions
          onTap: () {
            if (state.code == LibraryBookListStateCode.selecting) {
              // Selection mode.
              if (isSelected) {
                BlocProvider.of<LibraryBookListCubit>(context).removeSelect(state, chapterName);
              } else {
                BlocProvider.of<LibraryBookListCubit>(context).addSelect(state, chapterName);
              }
            } else {
              // Open mode.
              Navigator.of(context).push(_routeToChapterPage());
            }
          },
          onLongPress: () {
            if (!isSlideOpen) {
              BlocProvider.of<LibraryBookListCubit>(context).addSelect(state, chapterName);
            }
          },
        ),
      ),
    );
  }

  Future<T?> _showConfirmDialog<T>(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.confirm_title),
          content: Text(AppLocalizations.of(context)!.confirm_content_delete),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: Text(
                  AppLocalizations.of(context)!.delete,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                  ),
                )),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text(AppLocalizations.of(context)!.cancel)),
          ],
        );
      },
    );
  }

  Route _routeToEditPage() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => BookFormPage(BookFormType.edit, oldBookName: chapterName),
      transitionsBuilder: routeBottomSlideTransition,
    );
  }

  Route _routeToChapterPage() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => ChapterList(bookName: chapterName),
      transitionsBuilder: routeBottomSlideTransition,
    );
  }
}
