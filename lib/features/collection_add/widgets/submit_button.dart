part of '../collection_add_dialog.dart';

class _SubmitButton extends StatelessWidget {
  const _SubmitButton();

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return BlocBuilder<_Cubit, _State>(
      buildWhen: (_State previous, _State current) =>
          previous.name != current.name,
      builder: (BuildContext context, _State state) {
        final bool isDisabled = state.name?.isEmpty ?? true;
        return ElevatedButton.icon(
          onPressed: isDisabled ? null : () => _onPressed(context, state),
          style: ElevatedButton.styleFrom(
            iconColor: Theme.of(context).colorScheme.onPrimary,
            foregroundColor: Theme.of(context).colorScheme.onPrimary,
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
          icon: const Icon(Icons.send_rounded),
          label: Text(appLocalizations.generalSubmit),
        );
      },
    );
  }

  Future<void> _onPressed(
    BuildContext context,
    _State state,
  ) async {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final _Cubit cubit = BlocProvider.of<_Cubit>(context);
    if (Form.of(context).validate()) {
      cubit.submit();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            appLocalizations.collectionAddSuccess,
          ),
        ),
      );
      Navigator.of(context).pop(true);
    }
  }
}
