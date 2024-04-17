import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../toolbox/verify_utility.dart';

class CommonPasswordField extends StatelessWidget {
  const CommonPasswordField({super.key, this.isRequired = false, this.onSaved});

  final bool isRequired;
  final void Function(String?)? onSaved;

  @override
  Widget build(BuildContext context) {
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
      validator: (value) {
        if (isRequired && (value == null || value == '')) {
          return appLocalizations.fieldBlank;
        }

        if (value != null && !VerifyUtility.passwordAllowRegex.hasMatch(value)) {
          return appLocalizations.fieldInvalid;
        }

        return null;
      },
      onSaved: onSaved,
    );
  }
}