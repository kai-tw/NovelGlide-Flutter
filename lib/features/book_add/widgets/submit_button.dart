part of '../book_add_dialog.dart';

/// A button widget for submitting the selected book file.
class _SubmitButton extends StatelessWidget {
  const _SubmitButton();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final cubit = BlocProvider.of<_Cubit>(context);

    return BlocBuilder<_Cubit, _State>(
      buildWhen: (previous, current) => previous.file != current.file,
      builder: (context, state) {
        return ElevatedButton.icon(
          onPressed: state.file == null
              ? null
              : () => _onSubmitPressed(context, cubit),
          icon: const Icon(Icons.send_rounded),
          label: Text(AppLocalizations.of(context)!.generalSubmit),
          style: ElevatedButton.styleFrom(
            iconColor: colorScheme.onPrimary,
            foregroundColor: colorScheme.onPrimary,
            backgroundColor: colorScheme.primary,
          ),
        );
      },
    );
  }

  /// Handles the submit action.
  void _onSubmitPressed(BuildContext context, _Cubit cubit) {
    try {
      cubit.submit();
      Navigator.of(context).pop(true);
    } on FileDuplicatedException catch (_) {
      showDialog(
        context: context,
        builder: (_) => const _FileDuplicateErrorDialog(),
      );
    }
  }
}
