import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AccountEditNameField extends StatelessWidget {
  const AccountEditNameField({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    return TextFormField(
      decoration: InputDecoration(
        labelText: "${appLocalizations.nickname}${appLocalizations.fieldOptional}",
      ),
      inputFormatters: [
        FilteringTextInputFormatter.singleLineFormatter,
      ],
    );
  }
}