part of '../book_add_dialog.dart';

class _SubmitButton extends StatelessWidget {
  const _SubmitButton();

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final BookAddCubit cubit = BlocProvider.of<BookAddCubit>(context);

    return BlocBuilder<BookAddCubit, BookAddState>(
      buildWhen: (BookAddState previous, BookAddState current) =>
          previous.file != current.file,
      builder: (BuildContext context, BookAddState state) {
        if (state.isValid) {
          return ElevatedButton.icon(
            onPressed: () {
              BookRepository.add(cubit.state.filePath!);
              Navigator.of(context).pop(true);
            },
            icon: const Icon(Icons.send_rounded),
            label: Text(appLocalizations.generalSubmit),
            style: ElevatedButton.styleFrom(
              iconColor: colorScheme.onPrimary,
              foregroundColor: colorScheme.onPrimary,
              backgroundColor: colorScheme.primary,
            ),
          );
        } else {
          return IconButton(
            onPressed: null,
            icon: const Icon(Icons.send_rounded),
            tooltip: appLocalizations.generalSubmit,
            style: ElevatedButton.styleFrom(
              iconColor: colorScheme.onPrimary,
              foregroundColor: colorScheme.onPrimary,
              backgroundColor: colorScheme.primary,
            ),
          );
        }
      },
    );
  }
}
