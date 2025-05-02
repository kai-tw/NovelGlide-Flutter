part of '../book_add_page.dart';

class BookAddFileList extends StatelessWidget {
  const BookAddFileList({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return Scrollbar(
      child: BlocBuilder<BookAddCubit, BookAddState>(
        buildWhen: (BookAddState previous, BookAddState current) =>
            previous.pathSet != current.pathSet,
        builder: (BuildContext context, BookAddState state) {
          if (state.pathSet.isEmpty) {
            return Center(
              child: Text(appLocalizations.addBookEmpty),
            );
          } else {
            return ListView.builder(
              itemCount: state.pathSet.length,
              itemBuilder: (BuildContext context, int index) {
                return BookAddFileTile(
                  filePath: state.pathSet.elementAt(index),
                  index: index,
                );
              },
            );
          }
        },
      ),
    );
  }
}
