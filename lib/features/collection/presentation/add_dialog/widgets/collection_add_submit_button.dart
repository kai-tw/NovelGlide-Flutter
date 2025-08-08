part of '../../../collection_service.dart';

class CollectionAddSubmitButton extends StatelessWidget {
  const CollectionAddSubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return BlocBuilder<CollectionAddCubit, CollectionAddState>(
      buildWhen: (CollectionAddState previous, CollectionAddState current) =>
          previous.isValid != current.isValid,
      builder: (BuildContext context, CollectionAddState state) {
        return ElevatedButton.icon(
          onPressed: state.isValid ? () => _onPressed(context, state) : null,
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
    CollectionAddState state,
  ) async {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final CollectionAddCubit cubit =
        BlocProvider.of<CollectionAddCubit>(context);

    // Submit the form
    await cubit.submit();

    // Show up the success message
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            appLocalizations.collectionAddSuccess,
          ),
        ),
      );
      Navigator.of(context).pop();
    }
  }
}
