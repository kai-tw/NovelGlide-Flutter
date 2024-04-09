import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../toolbox/verify_utility.dart';
import 'bloc/login_page_bloc.dart';

class LoginPagePasswordField extends StatelessWidget {
  const LoginPagePasswordField({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginPageCubit cubit = BlocProvider.of<LoginPageCubit>(context);
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    return BlocBuilder<LoginPageCubit, LoginPageState>(
      builder: (context, state) {
        return TextFormField(
          decoration: InputDecoration(
            labelText: appLocalizations.password,
            prefixIcon: const Padding(
              padding: EdgeInsets.all(16.0),
              child: Icon(Icons.key_rounded),
            ),
            errorText: state.code == LoginPageStateCode.wrongPassword ? appLocalizations.passwordWrong : null,
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
      },
    );
  }

  String? codeToString(LoginPagePasswordCode code, AppLocalizations appLocalizations) {
    switch (code) {
      case LoginPagePasswordCode.blank:
        return appLocalizations.fieldBlank;
      case LoginPagePasswordCode.normal:
        return null;
      default:
        return appLocalizations.fieldInvalid;
    }
  }
}
