import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/book_object.dart';
import '../table_of_contents/table_of_content.dart';
import 'bloc/bookshelf_bloc.dart';
import 'bookshelf_book_cover.dart';
import 'bookshelf_book_title.dart';

class BookshelfSliverListItem extends StatelessWidget {
  const BookshelfSliverListItem(this.bookObject, {super.key});

  final BookObject bookObject;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookshelfCubit, BookshelfState>(
      builder: (BuildContext context, BookshelfState state) {
        final bool isSelected = state.selectedSet.contains(bookObject.name);
        return GestureDetector(
          onTap: () => _onTap(context, state.code, isSelected),
          onLongPress: () => _onLongPress(context, state.code),
          child: AnimatedContainer(
            margin: const EdgeInsets.all(8.0),
            height: 350.0,
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24.0),
              color: isSelected ? Theme.of(context).colorScheme.surfaceVariant : Colors.transparent,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  BookshelfBookCover(bookObject),
                  const Padding(padding: EdgeInsets.only(bottom: 16.0)),
                  BookshelfBookTitle(bookObject),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _onTap(BuildContext context, BookshelfStateCode code, bool isSelected) {
    final BookshelfCubit cubit = BlocProvider.of<BookshelfCubit>(context);
    switch (code) {
      case BookshelfStateCode.selecting:
        if (isSelected) {
          cubit.removeSelect(bookObject.name);
        } else {
          cubit.addSelect(bookObject.name);
        }
        break;
      case BookshelfStateCode.normal:
        Navigator.of(context).push(_navigateToTOC(cubit)).then(
          (isDirty) {
            if (isDirty == true) {
              cubit.refresh();
            }
          },
        );
      default:
    }
  }

  void _onLongPress(BuildContext context, BookshelfStateCode code) {
    final BookshelfCubit cubit = BlocProvider.of<BookshelfCubit>(context);
    switch (code) {
      case BookshelfStateCode.normal:
      case BookshelfStateCode.selecting:
        cubit.addSelect(bookObject.name);
        break;
      default:
    }
  }

  Route _navigateToTOC(BookshelfCubit cubit) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => TableOfContents(bookObject),
      transitionDuration: const Duration(milliseconds: 500),
      reverseTransitionDuration: const Duration(milliseconds: 500),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
              parent: animation,
              curve: Curves.easeInOut,
            ),
          ),
          child: child,
        );
      },
    );
  }
}
