import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../toolbox/verify_utility.dart';
import 'bloc/register_page_bloc.dart';

class RegisterPageConfirmPasswordField extends StatelessWidget {
  const RegisterPageConfirmPasswordField({super.key});

  @override
  Widget build(BuildContext context) {
    final RegisterPageCubit cubit = BlocProvider.of<RegisterPageCubit>(context);
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    return TextFormField(
      decoration: InputDecoration(
        labelText: appLocalizations.confirm + appLocalizations.password,
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
      validator: (value) => value == cubit.inputPassword ? null : appLocalizations.passwordNotMatch,
    );
  }

  String? codeToString(RegisterPagePasswordCode code, AppLocalizations appLocalizations) {
    switch (code) {
      case RegisterPagePasswordCode.blank:
        return appLocalizations.fieldBlank;
      case RegisterPagePasswordCode.normal:
        return null;
      default:
        return appLocalizations.fieldInvalid;
    }
  }
}
