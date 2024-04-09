import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'bloc/login_page_bloc.dart';

class LoginPageEmailField extends StatelessWidget {
  const LoginPageEmailField({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginPageCubit cubit = BlocProvider.of<LoginPageCubit>(context);
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    return BlocBuilder<LoginPageCubit, LoginPageState>(
      builder: (context, state) {
        return TextFormField(
          decoration: InputDecoration(
            labelText: appLocalizations.emailAddress,
            prefixIcon: const Padding(
              padding: EdgeInsets.all(16.0),
              child: Icon(Icons.email_rounded),
            ),
            errorText: state.code == LoginPageStateCode.userNotFound ? appLocalizations.userNotFound : null,
          ),
          keyboardType: TextInputType.emailAddress,
          inputFormatters: [
            FilteringTextInputFormatter.singleLineFormatter,
          ],
          initialValue: state.emailAddress,
          validator: (value) => codeToString(cubit.emailValidator(value), appLocalizations),
          onSaved: (value) => cubit.emailAddress = value,
        );
      },
    );
  }

  String? codeToString(LoginPageEmailCode code, AppLocalizations appLocalizations) {
    switch (code) {
      case LoginPageEmailCode.blank:
        return appLocalizations.fieldBlank;
      case LoginPageEmailCode.normal:
        return null;
      default:
        return appLocalizations.emailInvalid;
    }
  }
}
