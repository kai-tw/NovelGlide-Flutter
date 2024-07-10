import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../data/book_data.dart';
import '../homepage/bloc/homepage_bloc.dart';
import 'bloc/bookshelf_bloc.dart';
import 'bookshelf_book_widget.dart';

class BookshelfDraggableBook extends StatelessWidget {
  final BookData bookObject;

  const BookshelfDraggableBook(this.bookObject, {super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final BookshelfCubit cubit = BlocProvider.of<BookshelfCubit>(context);
    final HomepageCubit homepageCubit = BlocProvider.of<HomepageCubit>(context);

    return LayoutBuilder(
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
    );
  }

  Widget _createBookWidget(BuildContext context, BoxConstraints constraints) {
    return Container(
      width: constraints.maxWidth,
      height: constraints.maxHeight,
      padding: const EdgeInsets.all(16.0),
      color: Colors.transparent,
      child: BookshelfBookWidget(bookObject: bookObject),
    );
  }
}