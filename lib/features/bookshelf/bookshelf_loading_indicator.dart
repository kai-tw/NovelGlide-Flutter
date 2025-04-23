part of 'bookshelf.dart';

class BookshelfLoadingIndicator extends StatelessWidget {
  const BookshelfLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookshelfCubit, CommonListState<BookData>>(
      buildWhen: (CommonListState<BookData> previous,
              CommonListState<BookData> current) =>
          previous.code != current.code,
      builder: (BuildContext context, CommonListState<BookData> state) {
        if (state.code.isBackgroundLoading) {
          return const LinearProgressIndicator();
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
