import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/input_validators/not_empty_validator.dart';
import '../../../../../core/input_validators/url_validator.dart';
import '../../../../../generated/i18n/app_localizations.dart';
import '../cubits/explore_add_favorite_page_cubit.dart';

class ExploreAddFavoritePageForm extends StatelessWidget {
  const ExploreAddFavoritePageForm({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final ExploreAddFavoritePageCubit cubit =
        BlocProvider.of<ExploreAddFavoritePageCubit>(context);
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
                appLocalizations.exploreAddToFavorites,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 48.0),
              child: Text(
                appLocalizations.exploreAddFavoriteSubtitle,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: appLocalizations.generalName,
                  helperText: appLocalizations.exploreAddFavoriteNameHelperText,
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
                labelText: appLocalizations.generalUrl,
                helperText: appLocalizations.exploreAddFavoriteUrlHelperText,
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
