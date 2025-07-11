part of '../bookshelf.dart';

class _DraggableBook extends StatelessWidget {
  const _DraggableBook({
    required this.bookData,
    required this.isDraggable,
  });

  final BookData bookData;
  final bool isDraggable;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final BookshelfCubit cubit = BlocProvider.of<BookshelfCubit>(context);
    final HomepageCubit homepageCubit = BlocProvider.of<HomepageCubit>(context);

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return LongPressDraggable<BookData>(
          onDragStarted: () {
            cubit.isDragging = true;
            homepageCubit.isEnabled = false;
          },
          onDragEnd: (_) {
            cubit.isDragging = false;
            homepageCubit.isEnabled = true;
          },
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
          maxSimultaneousDrags: isDraggable ? 1 : 0,
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
