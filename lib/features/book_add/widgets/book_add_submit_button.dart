import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../exceptions/file_exceptions.dart';
import '../../common_components/common_error_dialog.dart';
import '../bloc/book_add_bloc.dart';

/// A button widget for submitting the selected book file.
class BookAddSubmitButton extends StatelessWidget {
  const BookAddSubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final cubit = BlocProvider.of<BookAddCubit>(context);

    return BlocBuilder<BookAddCubit, BookAddState>(
      buildWhen: (previous, current) => previous.file != current.file,
      builder: (context, state) {
        return ElevatedButton.icon(
          onPressed: state.file == null
              ? null
              : () => _onSubmitPressed(context, cubit),
          icon: const Icon(Icons.send_rounded),
          label: Text(AppLocalizations.of(context)!.generalSubmit),
          style: ElevatedButton.styleFrom(
            foregroundColor: colorScheme.onPrimary,
            backgroundColor: colorScheme.primary,
          ),
        );
      },
    );
  }

  /// Handles the submit action.
  void _onSubmitPressed(BuildContext context, BookAddCubit cubit) {
    try {
      cubit.submit();
      Navigator.of(context).pop(true);
    } on FileDuplicatedException catch (_) {
      _showDuplicateFileDialog(context);
    }
  }

  /// Shows a dialog when a duplicate file is detected.
  void _showDuplicateFileDialog(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (context) => CommonErrorDialog(
        title: appLocalizations.addBookFailed,
        content: appLocalizations.addBookDuplicated,
      ),
    );
  }
}
