part of '../book_add_dialog.dart';

class _PickFileButton extends StatelessWidget {
  const _PickFileButton();

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;
    final cubit = BlocProvider.of<BookAddCubit>(context);

    return BlocBuilder<BookAddCubit, BookAddState>(
      buildWhen: (previous, current) => previous.file != current.file,
      builder: (context, state) {
        return ElevatedButton.icon(
          onPressed: cubit.pickFile,
          icon: const Icon(Icons.file_open_rounded),
          label: Text(appLocalizations.generalSelect),
          style: ElevatedButton.styleFrom(
            iconColor: state.isValid ? null : colorScheme.onPrimary,
            foregroundColor: state.isValid ? null : colorScheme.onPrimary,
            backgroundColor: state.isValid ? null : colorScheme.primary,
          ),
        );
      },
    );
  }
}
