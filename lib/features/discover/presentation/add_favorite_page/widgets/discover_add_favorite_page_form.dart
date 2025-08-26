import 'package:flutter/material.dart';

import '../../../../../generated/i18n/app_localizations.dart';

class DiscoverAddFavoritePageForm extends StatelessWidget {
  const DiscoverAddFavoritePageForm({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return Form(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Text(
                appLocalizations.discoverAddFavorite,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 48.0),
              child: Text(
                appLocalizations.discoverAddFavoriteSubtitle,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: appLocalizations.generalName,
                  helperText:
                      appLocalizations.discoverAddFavoriteNameHelperText,
                ),
              ),
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: appLocalizations.discoverAddFavoriteUrlLabelText,
                helperText: appLocalizations.discoverAddFavoriteUrlHelperText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
