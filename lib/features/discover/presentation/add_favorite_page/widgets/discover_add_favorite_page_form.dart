import 'package:flutter/material.dart';
import 'package:flutter/src/services/text_formatter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/input_validators/not_empty_validator.dart';
import '../../../../../core/input_validators/url_validator.dart';
import '../../../../../generated/i18n/app_localizations.dart';
import '../cubits/discover_add_favorite_page_cubit.dart';

class DiscoverAddFavoritePageForm extends StatelessWidget {
  const DiscoverAddFavoritePageForm({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final DiscoverAddFavoritePageCubit cubit =
        BlocProvider.of<DiscoverAddFavoritePageCubit>(context);
    final NotEmptyValidator notEmptyValidator =
        NotEmptyValidator(appLocalizations);
    final UrlValidator urlValidator = UrlValidator(appLocalizations);

    return Form(
      key: cubit.formKey,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Text(
                appLocalizations.discoverAddToFavorites,
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
                validator: notEmptyValidator.validate,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.singleLineFormatter,
                ],
                onChanged: cubit.setName,
                onSaved: cubit.setName,
              ),
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: appLocalizations.discoverAddFavoriteUrlLabelText,
                helperText: appLocalizations.discoverAddFavoriteUrlHelperText,
              ),
              validator: urlValidator.validateLoosely,
              keyboardType: TextInputType.url,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.singleLineFormatter,
              ],
              onChanged: cubit.setUrl,
              onSaved: cubit.setUrl,
            ),
          ],
        ),
      ),
    );
  }
}
