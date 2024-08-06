import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../data/book_data.dart';
import '../table_of_contents/table_of_content.dart';
import 'bloc/bookshelf_bloc.dart';
import 'bookshelf_book_widget.dart';
import 'bookshelf_draggable_book.dart';
import 'widgets/bookshelf_select_checkbox.dart';

class BookshelfSliverListItem extends StatelessWidget {
  const BookshelfSliverListItem(this.bookData, {super.key});

  final BookData bookData;

  @override
  Widget build(BuildContext context) {
    final BookshelfCubit cubit = BlocProvider.of<BookshelfCubit>(context);

    return InkWell(
      onTap: () {
        if (cubit.state.isSelecting) {
          if (cubit.state.selectedBooks.contains(bookData.name)) {
            cubit.deselectBook(bookData.name);
          } else {
            cubit.selectBook(bookData.name);
          }
        } else {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => TableOfContents(bookData)))
              .then((_) => cubit.refresh());
        }
      },
      borderRadius: BorderRadius.circular(24.0),
      child: Stack(
        children: [
          BlocBuilder<BookshelfCubit, BookshelfState>(
            buildWhen: (previous, current) => previous.isSelecting != current.isSelecting,
            builder: (BuildContext context, BookshelfState state) {
              if (state.isSelecting) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: BookshelfBookWidget(bookObject: bookData),
                );
              } else {
                return Semantics(
                  label: AppLocalizations.of(context)!.accessibilityBookshelfListItem,
                  onTapHint: AppLocalizations.of(context)!.accessibilityBookshelfListItemOnTap,
                  onLongPressHint: AppLocalizations.of(context)!.accessibilityBookshelfListItemOnLongPress,
                  child: BookshelfDraggableBook(bookData),
                );
              }
            },
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: BlocBuilder<BookshelfCubit, BookshelfState>(
                  buildWhen: (previous, current) =>
                      previous.isSelecting != current.isSelecting || previous.selectedBooks != current.selectedBooks,
                  builder: (BuildContext context, BookshelfState state) {
                    return AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      transitionBuilder: (child, animation) => FadeTransition(opacity: animation, child: child),
                      child: state.isSelecting ? BookshelfSelectCheckbox(bookData: bookData) : null,
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
