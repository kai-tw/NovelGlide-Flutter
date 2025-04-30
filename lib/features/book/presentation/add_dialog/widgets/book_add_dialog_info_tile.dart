part of '../book_add_dialog.dart';

class BookAddDialogInfoTile extends StatelessWidget {
  const BookAddDialogInfoTile({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return BlocBuilder<BookAddCubit, BookAddState>(
      buildWhen: (BookAddState previous, BookAddState current) =>
          previous.file != current.file,
      builder: (BuildContext context, BookAddState state) {
        return ListTile(
          contentPadding: const EdgeInsets.only(bottom: 16.0),
          leading: const Icon(Icons.book_outlined, size: 48),
          title: Text(
            state.isEmpty
                ? appLocalizations.fileEmpty
                : basename(state.file!.path),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(FileUtils.getFileSizeString(state.fileLength)),
          textColor: Theme.of(context)
              .colorScheme
              .onSurface
              .withValues(alpha: state.isEmpty ? 0.7 : 1.0),
        );
      },
    );
  }
}
