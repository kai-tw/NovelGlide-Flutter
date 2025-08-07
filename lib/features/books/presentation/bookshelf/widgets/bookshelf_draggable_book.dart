import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../generated/i18n/app_localizations.dart';
import '../../../../homepage/cubit/homepage_cubit.dart';
import '../../../../shared_components/draggable_feedback_widget.dart';
import '../../../../shared_components/draggable_placeholder_widget.dart';
import '../../../../shared_components/shared_list/shared_list.dart';
import '../../../domain/entities/book.dart';
import '../cubit/bookshelf_cubit.dart';
import 'bookshelf_book_widget.dart';

class BookshelfDraggableBook extends StatelessWidget {
  const BookshelfDraggableBook({
    super.key,
    required this.bookData,
    required this.isDraggable,
    required this.isSelecting,
    required this.isSelected,
    this.onChanged,
    required this.listType,
  });

  final Book bookData;
  final bool isDraggable;
  final bool isSelecting;
  final bool isSelected;
  final ValueChanged<bool?>? onChanged;
  final SharedListType listType;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final BookshelfCubit cubit = BlocProvider.of<BookshelfCubit>(context);
    final HomepageCubit homepageCubit = BlocProvider.of<HomepageCubit>(context);

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final double? contraintHeight =
            listType == SharedListType.grid ? constraints.maxHeight : null;
        final EdgeInsets padding = listType == SharedListType.grid
            ? const EdgeInsets.all(16.0)
            : EdgeInsets.zero;

        return LongPressDraggable<Book>(
          onDragStarted: () {
            cubit.isDragging = true;
            homepageCubit.isEnabled = false;
          },
          onDragEnd: (_) {
            cubit.isDragging = false;
            homepageCubit.isEnabled = true;
          },
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
          maxSimultaneousDrags: isDraggable ? 1 : 0,
          feedback: DraggableFeedbackWidget(
            width: constraints.maxWidth,
            height: contraintHeight,
            padding: padding,
            child: BookshelfBookWidget(
              bookData: bookData,
              listType: listType,
            ),
          ),
          childWhenDragging: DraggablePlaceholderWidget(
            width: constraints.maxWidth,
            height: contraintHeight,
            padding: padding,
            child: BookshelfBookWidget(
              bookData: bookData,
              listType: listType,
            ),
          ),
          child: Container(
            width: constraints.maxWidth,
            height: contraintHeight,
            padding: padding,
            color: Colors.transparent,
            child: BookshelfBookWidget(
              bookData: bookData,
              isSelecting: isSelecting,
              isSelected: isSelected,
              onChanged: onChanged,
              listType: listType,
            ),
          ),
        );
      },
    );
  }
}
