import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../toolbox/verify_utility.dart';

class RegisterPageEmailField extends StatelessWidget {
  const RegisterPageEmailField({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return TextFormField(
      decoration: InputDecoration(
        labelText: appLocalizations.emailAddress,
        prefixIcon: const Icon(Icons.email_rounded),
      ),
      keyboardType: TextInputType.emailAddress,
      inputFormatters: [
        FilteringTextInputFormatter.singleLineFormatter,
        FilteringTextInputFormatter.deny(VerifyUtility.emailDenyRegex),
      ],
    );
  }
}
