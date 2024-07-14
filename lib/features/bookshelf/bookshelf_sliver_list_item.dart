import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../data/book_data.dart';
import '../table_of_contents/table_of_content.dart';
import 'bloc/bookshelf_bloc.dart';
import 'bookshelf_draggable_book.dart';

class BookshelfSliverListItem extends StatelessWidget {
  const BookshelfSliverListItem(this.bookObject, {super.key});

  final BookData bookObject;

  @override
  Widget build(BuildContext context) {
    final BookshelfCubit cubit = BlocProvider.of<BookshelfCubit>(context);

    return InkWell(
      borderRadius: BorderRadius.circular(24.0),
      onTap: () {
        Navigator.of(context).push(_tocRoute(cubit)).then((_) => cubit.refresh());
      },
      child: Semantics(
        label: AppLocalizations.of(context)!.accessibilityBookshelfListItem,
        onTapHint: AppLocalizations.of(context)!.accessibilityBookshelfListItemOnTap,
        onLongPressHint: AppLocalizations.of(context)!.accessibilityBookshelfListItemOnLongPress,
        child: BookshelfDraggableBook(bookObject),
      ),
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
