part of '../book_add_dialog.dart';

class _FormFileHelperText extends StatelessWidget {
  const _FormFileHelperText();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 48.0),
      child: Text('${AppLocalizations.of(context)!.fileTypeHelperText} epub'),
    );
  }
}
