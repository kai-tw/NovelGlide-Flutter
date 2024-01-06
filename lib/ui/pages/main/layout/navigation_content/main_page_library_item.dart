import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novelglide/ui/pages/main/bloc/library_book_list.dart';

class MainPageLibraryItem extends StatelessWidget {
  const MainPageLibraryItem(this.state, this.bookName, {super.key});

  final LibraryBookListState state;
  final String bookName;

  @override
  Widget build(BuildContext context) {
    bool isSelected = state.selectedBook.contains(bookName);
    return GestureDetector(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(16.0)),
            color: isSelected ? Theme.of(context).colorScheme.onTertiary : Colors.transparent,
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(bookName),
          ),
        ),
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
        onLongPress: () => BlocProvider.of<LibraryBookListCubit>(context).addSelect(state, bookName));
  }
}
