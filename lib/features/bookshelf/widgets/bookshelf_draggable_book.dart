import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../data_model/book_data.dart';
import '../../common_components/draggable_feedback_widget.dart';
import '../../common_components/draggable_placeholder_widget.dart';
import '../bloc/bookshelf_bloc.dart';
import 'bookshelf_book_widget.dart';

class BookshelfDraggableBook extends StatelessWidget {
  final BookData bookData;

  const BookshelfDraggableBook(this.bookData, {super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final BookshelfCubit cubit = BlocProvider.of<BookshelfCubit>(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        return LongPressDraggable(
          onDragStarted: () => cubit.setDragging(true),
          onDragEnd: (_) => cubit.setDragging(false),
          onDragCompleted: () async {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(await cubit.deleteBook(bookData)
                    ? appLocalizations.deleteBookSuccessfully
                    : appLocalizations.deleteBookFailed),
              ),
            );
          },
          data: bookData,
          feedback: DraggableFeedbackWidget(
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            padding: const EdgeInsets.all(16.0),
            child: BookshelfBookWidget(bookData: bookData),
          ),
          childWhenDragging: DraggablePlaceholderWidget(
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            padding: const EdgeInsets.all(16.0),
            child: BookshelfBookWidget(bookData: bookData),
          ),
          child: Container(
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            padding: const EdgeInsets.all(16.0),
            color: Colors.transparent,
            child: BookshelfBookWidget(bookData: bookData),
          ),
        );
      },
    );
  }
}
