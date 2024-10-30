import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../repository/collection_repository.dart';
import '../bloc/collection_add_bloc.dart';

class CollectionAddSubmitButton extends StatelessWidget {
  const CollectionAddSubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return BlocBuilder<CollectionAddCubit, CollectionAddState>(
      buildWhen: (previous, current) => previous.name != current.name,
      builder: (context, state) {
        final isDisabled = state.name == null || state.name!.isEmpty;
        return ElevatedButton.icon(
          onPressed: isDisabled ? null : () => _onPressed(context, state),
          style: ElevatedButton.styleFrom(
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
    final appLocalizations = AppLocalizations.of(context)!;
    if (Form.of(context).validate()) {
      Form.of(context).save();

      CollectionRepository.create(state.name!);

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
