import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'bloc/register_page_bloc.dart';

class RegisterPageEmailField extends StatelessWidget {
  const RegisterPageEmailField({super.key});

  @override
  Widget build(BuildContext context) {
    final RegisterPageCubit cubit = BlocProvider.of<RegisterPageCubit>(context);
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    return BlocBuilder<RegisterPageCubit, RegisterPageState>(
      builder: (context, state) {
        return TextFormField(
          decoration: InputDecoration(
            labelText: appLocalizations.emailAddress,
            prefixIcon: const Padding(
              padding: EdgeInsets.all(16.0),
              child: Icon(Icons.email_rounded),
            ),
            errorText: state.code == RegisterPageStateCode.emailUsed ? appLocalizations.emailUsed : null,
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

  String? codeToString(RegisterPageEmailCode code, AppLocalizations appLocalizations) {
    switch (code) {
      case RegisterPageEmailCode.blank:
        return appLocalizations.fieldBlank;
      case RegisterPageEmailCode.normal:
        return null;
      default:
        return appLocalizations.emailInvalid;
    }
  }
}
