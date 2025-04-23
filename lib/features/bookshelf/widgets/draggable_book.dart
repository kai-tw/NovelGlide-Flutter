part of '../bookshelf.dart';

class _DraggableBook extends StatelessWidget {
  const _DraggableBook(this.bookData);

  final BookData bookData;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final BookshelfCubit cubit = BlocProvider.of<BookshelfCubit>(context);

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return LongPressDraggable<BookData>(
          onDragStarted: () => cubit.setDragging(true),
          onDragEnd: (_) => cubit.setDragging(false),
          onDragCompleted: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(cubit.deleteBook(bookData)
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
            child: _BookWidget(bookData: bookData),
          ),
          childWhenDragging: DraggablePlaceholderWidget(
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            padding: const EdgeInsets.all(16.0),
            child: _BookWidget(bookData: bookData),
          ),
          child: Container(
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            padding: const EdgeInsets.all(16.0),
            color: Colors.transparent,
            child: _BookWidget(bookData: bookData),
          ),
        );
      },
    );
  }
}
