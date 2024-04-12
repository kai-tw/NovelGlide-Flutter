import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../toolbox/verify_utility.dart';
import 'bloc/sign_in_page_bloc.dart';

class SignInPagePasswordField extends StatelessWidget {
  const SignInPagePasswordField({super.key});

  @override
  Widget build(BuildContext context) {
    final SignInPageCubit cubit = SignInPageCubit();
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    return TextFormField(
      decoration: InputDecoration(
        labelText: appLocalizations.password,
        prefixIcon: const Padding(
          padding: EdgeInsets.all(16.0),
          child: Icon(Icons.key_rounded),
        ),
      ),
      obscureText: true,
      autocorrect: false,
      enableSuggestions: false,
      enableIMEPersonalizedLearning: false,
      inputFormatters: [
        FilteringTextInputFormatter.singleLineFormatter,
        FilteringTextInputFormatter.allow(VerifyUtility.passwordAllowRegex),
      ],
      validator: (value) => codeToString(cubit.passwordValidator(value), appLocalizations),
      onSaved: (value) => cubit.password = value,
    );
  }

  String? codeToString(SignInPagePasswordCode code, AppLocalizations appLocalizations) {
    switch (code) {
      case SignInPagePasswordCode.blank:
        return appLocalizations.fieldBlank;
      case SignInPagePasswordCode.normal:
        return null;
      default:
        return appLocalizations.fieldInvalid;
    }
  }
}
