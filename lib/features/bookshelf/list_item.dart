import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/book_object.dart';
import '../table_of_contents/index.dart';
import 'bloc/bookshelf_bloc.dart';

class BookshelfListItem extends StatelessWidget {
  const BookshelfListItem(this.bookObject, {super.key});

  final BookObject bookObject;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookshelfCubit, BookshelfState>(
      builder: (BuildContext context, BookshelfState state) {
        final bool isSelected = state.selectedSet.contains(bookObject.name);
        return GestureDetector(
          onTap: () {
            switch (state.code) {
              case BookshelfStateCode.selecting:
                if (isSelected) {
                  BlocProvider.of<BookshelfCubit>(context).removeSelect(bookObject.name);
                } else {
                  BlocProvider.of<BookshelfCubit>(context).addSelect(bookObject.name);
                }
                break;
              case BookshelfStateCode.normal:
                Navigator.of(context).push(_navigateToTOC()).then((_) {
                  BlocProvider.of<BookshelfCubit>(context).refresh();
                });
              default:
            }
          },
          onLongPress: () {
            switch (state.code) {
              case BookshelfStateCode.normal:
              case BookshelfStateCode.selecting:
                BlocProvider.of<BookshelfCubit>(context).addSelect(bookObject.name);
                break;
              default:
            }
          },
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
                  AspectRatio(
                    aspectRatio: 1 / 1.5,
                    child: Hero(
                      tag: bookObject.name,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surfaceVariant,
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        clipBehavior: Clip.hardEdge,
                        child: bookObject.getCover(),
                      ),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 16.0)),
                  Text(
                    bookObject.name,
                    maxLines: 3,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Route _navigateToTOC() {
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
