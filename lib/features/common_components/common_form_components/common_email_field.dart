import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CommonEmailField extends StatelessWidget {
  const CommonEmailField({super.key, this.isRequired = false, this.onSaved});

  final bool isRequired;
  final void Function(String?)? onSaved;

  @override
  Widget build(BuildContext context) {
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
      validator: (value) {
        if (isRequired && (value == null || value == '')) {
          return appLocalizations.fieldBlank;
        }

        if (value != null && !EmailValidator.validate(value)) {
          return appLocalizations.emailInvalid;
        }

        return null;
      },
      onSaved: onSaved,
    );
  }
}