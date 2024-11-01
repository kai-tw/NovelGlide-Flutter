part of '../book_add_dialog.dart';

class _FileInfoListTile extends StatelessWidget {
  const _FileInfoListTile();

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return BlocBuilder<_Cubit, _State>(
      buildWhen: (previous, current) => previous.file != current.file,
      builder: (context, state) {
        final fileName = state.file != null
            ? basename(state.file!.path)
            : appLocalizations.fileEmpty;
        final fileSize = state.file?.lengthSync() ?? 0;
        final textStyle = TextStyle(
          color: Theme.of(context)
              .colorScheme
              .onSurface
              .withOpacity(state.file == null ? 0.7 : 1.0),
        );

        return ListTile(
          contentPadding: const EdgeInsets.only(bottom: 16.0),
          leading: const Icon(Icons.book_outlined, size: 48),
          title: Text(
            fileName,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: textStyle,
          ),
          subtitle: Text(
            FileUtils.getFileSizeString(fileSize),
            style: textStyle,
          ),
        );
      },
    );
  }
}
