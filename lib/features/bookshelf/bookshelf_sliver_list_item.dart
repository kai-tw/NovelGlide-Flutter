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
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => TableOfContents(bookObject)))
            .then((_) => cubit.refresh());
      },
      child: Semantics(
        label: AppLocalizations.of(context)!.accessibilityBookshelfListItem,
        onTapHint: AppLocalizations.of(context)!.accessibilityBookshelfListItemOnTap,
        onLongPressHint: AppLocalizations.of(context)!.accessibilityBookshelfListItemOnLongPress,
        child: BookshelfDraggableBook(bookObject),
      ),
    );
  }
}
