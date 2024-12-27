part of '../book_add_dialog.dart';

class _PickFileButton extends StatelessWidget {
  const _PickFileButton();

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;

    return BlocBuilder<_Cubit, _State>(
      buildWhen: (previous, current) => previous.file != current.file,
      builder: (context, state) {
        return ElevatedButton.icon(
          onPressed: BlocProvider.of<_Cubit>(context).pickFile,
          icon: const Icon(Icons.file_open_rounded),
          label: Text(appLocalizations.generalSelect),
          style: ElevatedButton.styleFrom(
            iconColor: state.file == null ? colorScheme.onPrimary : null,
            foregroundColor: state.file == null ? colorScheme.onPrimary : null,
            backgroundColor: state.file == null ? colorScheme.primary : null,
          ),
        );
      },
    );
  }
}
