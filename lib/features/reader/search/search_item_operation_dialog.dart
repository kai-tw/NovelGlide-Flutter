part of 'search_scaffold.dart';

class _SearchItemOperationDialog extends StatelessWidget {
  final ReaderSearchResultData result;

  const _SearchItemOperationDialog(this.result);

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return Dialog(
      child: Container(
        constraints: BoxConstraints(maxWidth: WindowClass.compact.maxWidth),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text(appLocalizations.readerSearchCopyExcerpt),
              trailing: const Icon(Icons.content_copy_rounded),
              onTap: () {
                Clipboard.setData(ClipboardData(text: result.excerpt.trim()));
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
