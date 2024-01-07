import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:novelglide/ui/motion/motion_listener.dart';
import 'package:novelglide/ui/pages/main/bloc/library_book_list.dart';

class MainPageLibraryItem extends StatelessWidget {
  const MainPageLibraryItem(this.bookName, {super.key});

  final String bookName;

  @override
  Widget build(BuildContext context) {
    LibraryBookListState state = BlocProvider.of<LibraryBookListCubit>(context).state;
    bool isSelected = state.selectedBook.contains(bookName);
    bool isSlideOpen = false;
    Radius borderRadius = const Radius.circular(16.0);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: GestureDetector(
        child: AnimatedContainer(
          padding: const EdgeInsets.all(16.0),
          width: double.infinity,
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(borderRadius),
            color: isSelected ? Theme.of(context).colorScheme.onTertiary : Colors.transparent,
          ),
          clipBehavior: Clip.hardEdge,
          child: Slidable(
            groupTag: 'LibraryBookList',
            closeOnScroll: false,
            endActionPane: ActionPane(
              extentRatio: 0.2,
              motion: MotionListener(
                onOpenEnd: () {
                  BlocProvider.of<LibraryBookListCubit>(context).removeSelect(state, bookName);
                  isSlideOpen = true;
                },
                onClose: () => isSlideOpen = false,
                motionWidget: const DrawerMotion(),
              ),
              children: [
                SlidableAction(
                  padding: const EdgeInsets.all(0.0),
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
            child: SizedBox(
              width: double.infinity,
              child: Row(
                children: [
                  Padding(
                    padding: state.isSelecting ? const EdgeInsets.only(right: 12.0) : const EdgeInsets.all(0),
                    child: Icon(
                      isSelected ? Icons.check : Icons.check_box_outline_blank_rounded,
                      size: state.isSelecting ? 20 : 0,
                    ),
                  ),
                  Text(bookName),
                ],
              ),
            ),
          ),
        ),

        /// Actions
        onTap: () {
          if (state.isSelecting) {
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
}
