import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../data/collection_data.dart';
import '../bloc/collection_add_bloc.dart';

class CollectionAddSubmitButton extends StatelessWidget {
  const CollectionAddSubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    return BlocBuilder<CollectionAddCubit, CollectionAddState>(
      buildWhen: (previous, current) => previous.name != current.name,
      builder: (context, state) {
        final isDisabled = state.name == null || state.name!.isEmpty;
        return ElevatedButton.icon(
          onPressed: isDisabled
              ? null
              : () async {
                  if (Form.of(context).validate()) {
                    final ScaffoldMessengerState messenger =
                        ScaffoldMessenger.of(context);
                    final NavigatorState navigator = Navigator.of(context);

                    Form.of(context).save();

                    await CollectionData.create(state.name!);

                    messenger.showSnackBar(
                      SnackBar(
                        content: Text(
                          appLocalizations?.collectionAddSuccess ??
                              'The collection was added successfully.',
                        ),
                      ),
                    );
                    navigator.pop();
                  }
                },
          style: ElevatedButton.styleFrom(
            foregroundColor: Theme.of(context).colorScheme.onPrimary,
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
          icon: const Icon(Icons.send_rounded),
          label: Text(appLocalizations?.generalSubmit ?? 'Submit'),
        );
      },
    );
  }
}
