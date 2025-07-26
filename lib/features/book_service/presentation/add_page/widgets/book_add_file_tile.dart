part of '../../../book_service.dart';

class BookAddFileTile extends StatelessWidget {
  const BookAddFileTile({
    super.key,
    required this.filePath,
    required this.baseName,
    required this.lengthString,
    required this.isValid,
    required this.isDuplicated,
    required this.isMimeValid,
    required this.onDeletePressed,
  });

  final String filePath;
  final String baseName;
  final String lengthString;
  final bool isValid;
  final bool isDuplicated;
  final bool isMimeValid;
  final void Function() onDeletePressed;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    String subtitle = lengthString;

    // Check if the file is duplicated
    if (isDuplicated) {
      subtitle = appLocalizations.addBookDuplicated;
    }

    // Check if the file is invalid
    if (!isMimeValid) {
      subtitle = appLocalizations.fileTypeForbidden;
    }

    return ListTile(
      leading: Icon(
        isValid ? Icons.book_rounded : Icons.error_rounded,
        color: isValid ? null : Theme.of(context).colorScheme.error,
      ),
      title: Text(
        baseName,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          color: isValid ? null : Theme.of(context).colorScheme.error,
        ),
      ),
      trailing: IconButton(
        onPressed: onDeletePressed,
        icon: const Icon(Icons.delete),
        tooltip: appLocalizations.generalDelete,
      ),
    );
  }
}
