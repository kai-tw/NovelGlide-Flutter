import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:novelglide/features/chapter_list/bloc/chapter_list_bloc.dart';
import 'package:novelglide/ui/components/view_list/bloc.dart';
import 'package:novelglide/ui/components/view_list/slide_action_delete.dart';
import 'package:novelglide/ui/components/view_list/slide_action_edit.dart';
import 'package:novelglide/shared/motion_listener.dart';
import 'package:novelglide/shared/route_slide_transition.dart';

import '../../book_form/bloc/form_bloc.dart';
import '../../book_form/layout/main.dart';
import 'chapter_list.dart';

class ChapterItem extends StatelessWidget {
  const ChapterItem(this.chapterName, {super.key});

  final String chapterName;

  @override
  Widget build(BuildContext context) {
    ViewListState state = BlocProvider.of<ChapterListCubit>(context).state;
    bool isSelected = state.selectedSet.contains(chapterName);
    bool isSlideOpen = state.slidedSet.contains(chapterName);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
      ),
      clipBehavior: Clip.hardEdge,
      child: Slidable(
        groupTag: 'ChapterList',
        closeOnScroll: false,
        endActionPane: ActionPane(
          extentRatio: 0.4,
          motion: MotionListener(
            onOpenEnd: () {
              BlocProvider.of<ChapterListCubit>(context).addSlide(state, chapterName);
            },
            onClose: () {
              BlocProvider.of<ChapterListCubit>(context).removeSlide(state, chapterName);
            },
            motionWidget: const DrawerMotion(),
          ),
          children: const [
            SlideActionEdit(),
            SlideActionDelete(),
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
                    width: state.code == ViewListStateCode.selecting ? 20.0 : 0.0,
                    child: Icon(
                      isSelected ? Icons.check : Icons.check_box_outline_blank_rounded,
                      size: state.code == ViewListStateCode.selecting ? 20.0 : 0.0,
                    ),
                  ),
                  Expanded(child: Text(chapterName)),
                ],
              ),
            ),
          ),

          /// Actions
          onTap: () {
            if (state.code == ViewListStateCode.selecting) {
              // Selection mode.
              if (isSelected) {
                BlocProvider.of<ChapterListCubit>(context).removeSelect(state, chapterName);
              } else {
                BlocProvider.of<ChapterListCubit>(context).addSelect(state, chapterName);
              }
            } else {
              // Open mode.
              // Navigator.of(context).push(_routeToChapterPage());
            }
          },
          onLongPress: () {
            if (!isSlideOpen) {
              BlocProvider.of<ChapterListCubit>(context).addSelect(state, chapterName);
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
