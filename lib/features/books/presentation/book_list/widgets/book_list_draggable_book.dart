import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../generated/i18n/app_localizations.dart';
import '../../../../homepage/cubit/homepage_cubit.dart';
import '../../../../shared_components/draggable_feedback_widget.dart';
import '../../../../shared_components/draggable_placeholder_widget.dart';
import '../../../../shared_components/shared_list/shared_list.dart';
import '../../../domain/entities/book.dart';
import '../../../domain/entities/book_cover.dart';
import '../../book_widget/book_widget.dart';
import '../cubit/book_list_cubit.dart';

class BookListDraggableBook extends StatelessWidget {
  const BookListDraggableBook({
    super.key,
    required this.bookData,
    required this.coverData,
    required this.isDraggable,
    required this.isSelecting,
    required this.isSelected,
    this.onChanged,
    required this.listType,
  });

  final Book bookData;
  final BookCover coverData;
  final bool isDraggable;
  final bool isSelecting;
  final bool isSelected;
  final ValueChanged<bool?>? onChanged;
  final SharedListType listType;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final BookListCubit cubit = BlocProvider.of<BookListCubit>(context);
    final HomepageCubit homepageCubit = BlocProvider.of<HomepageCubit>(context);

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final double? constraintHeight =
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
            height: constraintHeight,
            padding: padding,
            child: BookWidget(
              bookData: bookData,
              coverData: coverData,
              listType: listType,
            ),
          ),
          childWhenDragging: DraggablePlaceholderWidget(
            width: constraints.maxWidth,
            height: constraintHeight,
            padding: padding,
            child: BookWidget(
              bookData: bookData,
              coverData: coverData,
              listType: listType,
            ),
          ),
          child: Container(
            width: constraints.maxWidth,
            height: constraintHeight,
            padding: padding,
            color: Colors.transparent,
            child: BookWidget(
              bookData: bookData,
              coverData: coverData,
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
