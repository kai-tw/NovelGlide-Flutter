import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../toolbox/verify_utility.dart';
import '../common_components/common_form_decoration.dart';

class RegisterPasswordField extends StatelessWidget {
  const RegisterPasswordField({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return TextFormField(
      decoration: CommonFormDecoration.inputDecoration(appLocalizations.password),
      obscureText: true,
      autocorrect: false,
      enableSuggestions: false,
      enableIMEPersonalizedLearning: false,
      inputFormatters: [
        FilteringTextInputFormatter.singleLineFormatter,
        FilteringTextInputFormatter.allow(VerifyUtility.passwordAllowRegex),
      ],
    );
  }
}