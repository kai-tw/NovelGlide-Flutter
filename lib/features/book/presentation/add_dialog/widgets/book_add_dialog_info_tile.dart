part of '../book_add_dialog.dart';

class BookAddDialogInfoTile extends StatelessWidget {
  const BookAddDialogInfoTile({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return BlocBuilder<BookAddCubit, BookAddState>(
      buildWhen: (BookAddState previous, BookAddState current) =>
          previous.fileList != current.fileList,
      builder: (BuildContext context, BookAddState state) {
        String titleText = appLocalizations.fileEmpty;

        if (state.fileList.length == 1) {
          titleText = basename(state.fileList[0].path);
        } else if (state.fileList.isNotEmpty) {
          // TODO(author): translate.
          titleText = '${state.fileList.length} files';
        }

        return ListTile(
          contentPadding: const EdgeInsets.only(bottom: 16.0),
          leading: const Icon(Icons.book_outlined, size: 48),
          title: Text(
            titleText,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(FileUtils.getFileSizeString(state.totalFileSize)),
          textColor: Theme.of(context)
              .colorScheme
              .onSurface
              .withValues(alpha: state.isEmpty ? 0.7 : 1.0),
        );
      },
    );
  }
}
