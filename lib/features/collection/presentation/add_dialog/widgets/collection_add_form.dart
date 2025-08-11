import 'package:flutter/material.dart';

import '../../../../../generated/i18n/app_localizations.dart';
import 'collection_add_close_button.dart';
import 'collection_add_name_field.dart';
import 'collection_add_submit_button.dart';

class CollectionAddForm extends StatelessWidget {
  const CollectionAddForm({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return Form(
      canPop: false,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              appLocalizations.collectionAddTitle,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 24.0),
              child: CollectionAddNameField(),
            ),
            const OverflowBar(
              alignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                CollectionAddCloseButton(),
                CollectionAddSubmitButton(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
