part of 'bookshelf.dart';

class BookshelfLoadingIndicator extends StatelessWidget {
  const BookshelfLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookshelfCubit, BookShelfState>(
      buildWhen: (BookShelfState previous, BookShelfState current) =>
          previous.code != current.code,
      builder: (BuildContext context, BookShelfState state) {
        if (state.code.isBackgroundLoading) {
          return const LinearProgressIndicator();
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
