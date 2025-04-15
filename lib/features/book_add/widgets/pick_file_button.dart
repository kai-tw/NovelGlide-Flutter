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
        if (state.isValid) {
          return IconButton(
            onPressed: cubit.pickFile,
            icon: const Icon(Icons.file_open_rounded),
            tooltip: appLocalizations.generalSelect,
          );
        } else {
          return ElevatedButton.icon(
            onPressed: cubit.pickFile,
            icon: const Icon(Icons.file_open_rounded),
            label: Text(appLocalizations.generalSelect),
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
