import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../data/book_data.dart';
import '../homepage/bloc/homepage_bloc.dart';
import '../table_of_contents/table_of_content.dart';
import 'bloc/bookshelf_bloc.dart';
import 'bookshelf_book_widget.dart';

class BookshelfSliverListItem extends StatelessWidget {
  const BookshelfSliverListItem(this.bookObject, {super.key});

  final BookData bookObject;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final BookshelfCubit cubit = BlocProvider.of<BookshelfCubit>(context);
    final HomepageCubit homepageCubit = BlocProvider.of<HomepageCubit>(context);

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(_tocRoute(cubit)).then(
          (isDirty) {
            if (isDirty == true) {
              cubit.refresh();
            }
          },
        );
      },
      child: LayoutBuilder(
        builder: (context, constraints) {
          return LongPressDraggable(
            onDragStarted: () => homepageCubit.setDragging(true),
            onDragEnd: (_) => homepageCubit.setDragging(false),
            onDragCompleted: () {
              final bool isSuccess = bookObject.delete();
              if (isSuccess) {
                cubit.refresh();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(appLocalizations.deleteBookSuccessfully),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(appLocalizations.deleteBookFailed),
                  ),
                );
              }
            },
            data: bookObject,
            feedback: Opacity(
              opacity: 0.7,
              child: _createBookWidget(context, constraints),
            ),
            childWhenDragging: const SizedBox(),
            child: _createBookWidget(context, constraints),
          );
        },
      ),
    );
  }

  Widget _createBookWidget(BuildContext context, BoxConstraints constraints) {
    return Container(
      width: constraints.maxWidth,
      height: constraints.maxHeight,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(24.0),
      ),
      clipBehavior: Clip.hardEdge,
      child: BookshelfBookWidget(bookObject: bookObject),
    );
  }

  Route _tocRoute(BookshelfCubit cubit) {
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
