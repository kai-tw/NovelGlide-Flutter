import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../exceptions/file_exceptions.dart';
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
    final appLocalizations = AppLocalizations.of(context)!;
    final navigator = Navigator.of(context);
    final themeData = Theme.of(context);

    cubit.submit().then((_) {
      navigator.pop(true);
    }).catchError((e) {
      if (e is FileDuplicatedException && context.mounted) {
        _showDuplicateFileDialog(
          context,
          appLocalizations,
          themeData,
          navigator,
        );
      }
    });
  }

  /// Shows a dialog when a duplicate file is detected.
  void _showDuplicateFileDialog(
    BuildContext context,
    AppLocalizations appLocalizations,
    ThemeData themeData,
    NavigatorState navigator,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        icon: Icon(
          Icons.error_rounded,
          size: 48,
          color: themeData.colorScheme.error,
        ),
        title: Text(appLocalizations.addBookFailed),
        content: Text(appLocalizations.addBookDuplicated),
        actions: [
          TextButton(
            onPressed: () => navigator.pop(),
            child: Text(appLocalizations.generalClose),
          ),
        ],
      ),
    );
  }
}
