import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../data/book_data.dart';
import '../table_of_contents/table_of_content.dart';
import 'bloc/bookshelf_bloc.dart';
import 'widgets/bookshelf_draggable_book.dart';
import 'widgets/bookshelf_select_checkbox.dart';

class BookshelfSliverListItem extends StatelessWidget {
  const BookshelfSliverListItem(this.bookData, {super.key});

  final BookData bookData;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final BookshelfCubit cubit = BlocProvider.of<BookshelfCubit>(context);

    return InkWell(
      onTap: () {
        if (cubit.state.isSelecting) {
          if (cubit.state.selectedBooks.contains(bookData)) {
            cubit.deselectBook(bookData);
          } else {
            cubit.selectBook(bookData);
          }
        } else {
          if (bookData.isExist) {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => TableOfContents(bookData)));
          } else {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                icon: Icon(Icons.error_outline_rounded, color: Theme.of(context).colorScheme.error, size: 48.0),
                content: const Text("This book doesn't exist.", textAlign: TextAlign.center),
                actions: [
                  TextButton.icon(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close),
                    label: Text(appLocalizations.generalClose),
                  ),
                ],
              ),
            );
            cubit.refresh();
          }
        }
      },
      borderRadius: BorderRadius.circular(24.0),
      child: Stack(
        children: [
          Semantics(
            label: appLocalizations.accessibilityBookshelfListItem,
            onTapHint: appLocalizations.accessibilityBookshelfListItemOnTap,
            onLongPressHint: appLocalizations.accessibilityBookshelfListItemOnLongPress,
            child: BookshelfDraggableBook(bookData),
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
