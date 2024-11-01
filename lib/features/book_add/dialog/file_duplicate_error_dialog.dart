part of '../book_add_dialog.dart';

class _FileDuplicateErrorDialog extends StatelessWidget {
  const _FileDuplicateErrorDialog();

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return CommonErrorDialog(
      title: appLocalizations.addBookFailed,
      content: appLocalizations.addBookDuplicated,
    );
  }
}
