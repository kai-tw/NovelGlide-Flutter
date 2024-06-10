import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../common_components/common_form_components/common_form_submit_button.dart';
import 'account_edit_name_field.dart';
import 'account_edit_phone_field.dart';

class AccountEditNormalForm extends StatelessWidget {
  const AccountEditNormalForm({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 12.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.0),
      ),
      color: Theme.of(context).colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          child: Column(
            children: [
              const AccountEditNameField(),
              const Padding(padding: EdgeInsets.only(bottom: 24.0)),
              const AccountEditPhoneField(),
              const Padding(padding: EdgeInsets.only(bottom: 24.0)),
              Align(
                alignment: Alignment.centerRight,
                child: CommonFormSubmitButton(
                  iconData: Icons.save_rounded,
                  labelText: appLocalizations.save,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
