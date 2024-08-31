import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../data/collection_data.dart';
import 'bloc/collection_add_bloc.dart';

class CollectionAddForm extends StatelessWidget {
  const CollectionAddForm({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return Form(
      key: formKey,
      canPop: false,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              appLocalizations.collectionAddTitle,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: appLocalizations.collectionName,
                ),
                inputFormatters: [FilteringTextInputFormatter.singleLineFormatter],
                onChanged: (value) {
                  BlocProvider.of<CollectionAddCubit>(context).name = value;
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton.icon(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.close_rounded),
                  label: Text(appLocalizations.generalCancel),
                ),
                BlocBuilder<CollectionAddCubit, CollectionAddState>(
                  buildWhen: (previous, current) => previous.name != current.name,
                  builder: (context, state) {
                    final isDisabled = state.name == null || state.name!.isEmpty;
                    return ElevatedButton.icon(
                      onPressed: isDisabled ? null : () {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();

                          CollectionData.fromName(state.name!).save();

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(appLocalizations.collectionAddSuccess),
                            ),
                          );

                          Navigator.of(context).pop();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Theme.of(context).colorScheme.onPrimary,
                        backgroundColor: Theme.of(context).colorScheme.primary,
                      ),
                      icon: const Icon(Icons.send_rounded),
                      label: Text(appLocalizations.generalSubmit),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}