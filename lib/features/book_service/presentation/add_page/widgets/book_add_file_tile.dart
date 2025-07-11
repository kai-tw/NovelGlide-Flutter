part of '../book_add_page.dart';

class BookAddFileTile extends StatelessWidget {
  const BookAddFileTile(
      {super.key, required this.filePath, required this.index});

  final String filePath;
  final int index;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final BookAddCubit cubit = BlocProvider.of<BookAddCubit>(context);
    final File file = File(filePath);
    bool isError = false;
    String subtitle = FileUtils.getFileSizeString(file.lengthSync());

    // Check if the file is duplicated
    if (BookRepository.exists(filePath)) {
      isError = true;
      subtitle = appLocalizations.addBookDuplicated;
    }

    // Check if the file is invalid
    if (MimeResolver.lookupAll(file) != 'application/epub+zip') {
      isError = true;
      subtitle = appLocalizations.fileTypeForbidden;
    }

    return ListTile(
      leading: Icon(
        isError ? Icons.error_rounded : Icons.book_rounded,
        color: isError ? Theme.of(context).colorScheme.error : null,
      ),
      title: Text(
        basename(filePath),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          color: isError ? Theme.of(context).colorScheme.error : null,
        ),
      ),
      trailing: IconButton(
        onPressed: () => cubit.removeFile(filePath),
        icon: const Icon(Icons.delete),
        tooltip: appLocalizations.generalDelete,
      ),
    );
  }
}
