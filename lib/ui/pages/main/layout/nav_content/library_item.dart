import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:novelglide/ui/motion/motion_listener.dart';
import 'package:novelglide/ui/motion/route_slide_transition.dart';
import 'package:novelglide/ui/pages/book_form/bloc/form_bloc.dart';
import 'package:novelglide/ui/pages/book_form/layout/main.dart';
import 'package:novelglide/ui/pages/main/bloc/library_bloc.dart';

class MainPageLibraryItem extends StatelessWidget {
  const MainPageLibraryItem(this.bookName, {super.key});

  final String bookName;

  @override
  Widget build(BuildContext context) {
    LibraryBookListState state = BlocProvider.of<LibraryBookListCubit>(context).state;
    bool isSelected = state.selectedBooks.contains(bookName);
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
              BlocProvider.of<LibraryBookListCubit>(context).addSlide(state, bookName);
              isSlideOpen = true;
            },
            onClose: () {
              BlocProvider.of<LibraryBookListCubit>(context).removeSlide(state, bookName);
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
                Navigator.of(context).push(_routeToEditPage(bookName)).then((_) {
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
                    BlocProvider.of<LibraryBookListCubit>(context).deleteBook(state, bookName);
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
                  Expanded(child: Text(bookName)),
                ],
              ),
            ),
          ),

          /// Actions
          onTap: () {
            if (state.code == LibraryBookListStateCode.selecting) {
              // Selection mode.
              if (isSelected) {
                BlocProvider.of<LibraryBookListCubit>(context).removeSelect(state, bookName);
              } else {
                BlocProvider.of<LibraryBookListCubit>(context).addSelect(state, bookName);
              }
            } else {
              // Open mode.
              // TODO Open book.
            }
          },
          onLongPress: () {
            if (!isSlideOpen) {
              BlocProvider.of<LibraryBookListCubit>(context).addSelect(state, bookName);
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

  Route _routeToEditPage(String bookName) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => BookFormPage(BookFormType.edit, oldBookName: bookName),
      transitionsBuilder: routeBottomSlideTransition,
    );
  }
}
