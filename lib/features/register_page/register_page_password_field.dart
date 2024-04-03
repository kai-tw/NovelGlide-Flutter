import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../toolbox/verify_utility.dart';
import 'bloc/register_page_bloc.dart';

class RegisterPagePasswordField extends StatelessWidget {
  const RegisterPagePasswordField({super.key});

  @override
  Widget build(BuildContext context) {
    final RegisterPageCubit cubit = BlocProvider.of<RegisterPageCubit>(context);
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    return BlocBuilder<RegisterPageCubit, RegisterPageState>(
      builder: (context, state) {
        return TextFormField(
          decoration: InputDecoration(
            labelText: appLocalizations.password,
            prefixIcon: const Padding(
              padding: EdgeInsets.all(16.0),
              child: Icon(Icons.key_rounded),
            ),
            errorText: state.code == RegisterPageStateCode.weakPassword ? appLocalizations.passwordWeak : null,
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
