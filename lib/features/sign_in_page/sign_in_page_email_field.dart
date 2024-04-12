import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'bloc/sign_in_page_bloc.dart';

class LoginPageEmailField extends StatelessWidget {
  const LoginPageEmailField({super.key});

  @override
  Widget build(BuildContext context) {
    final SignInPageCubit cubit = SignInPageCubit();
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    return TextFormField(
      decoration: InputDecoration(
        labelText: appLocalizations.emailAddress,
        prefixIcon: const Padding(
          padding: EdgeInsets.all(16.0),
          child: Icon(Icons.email_rounded),
        ),
      ),
      keyboardType: TextInputType.emailAddress,
      inputFormatters: [
        FilteringTextInputFormatter.singleLineFormatter,
      ],
      validator: (value) => codeToString(cubit.emailValidator(value), appLocalizations),
      onSaved: (value) => cubit.emailAddress = value,
    );
  }

  String? codeToString(SignInPageEmailCode code, AppLocalizations appLocalizations) {
    switch (code) {
      case SignInPageEmailCode.blank:
        return appLocalizations.fieldBlank;
      case SignInPageEmailCode.normal:
        return null;
      default:
        return appLocalizations.emailInvalid;
    }
  }
}
