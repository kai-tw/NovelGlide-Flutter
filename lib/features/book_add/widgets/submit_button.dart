part of '../book_add_dialog.dart';

class _SubmitButton extends StatelessWidget {
  const _SubmitButton();

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;
    final cubit = BlocProvider.of<BookAddCubit>(context);

    return BlocBuilder<BookAddCubit, BookAddState>(
      buildWhen: (previous, current) => previous.file != current.file,
      builder: (context, state) {
        return ElevatedButton.icon(
          onPressed: state.isValid
              ? () {
                  BookRepository.add(cubit.state.filePath!);
                  Navigator.of(context).pop(true);
                }
              : null,
          icon: const Icon(Icons.send_rounded),
          label: Text(appLocalizations.generalSubmit),
          style: ElevatedButton.styleFrom(
            iconColor: colorScheme.onPrimary,
            foregroundColor: colorScheme.onPrimary,
            backgroundColor: colorScheme.primary,
          ),
        );
      },
    );
  }
}
