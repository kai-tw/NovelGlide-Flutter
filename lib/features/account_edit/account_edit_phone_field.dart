import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'bloc/account_edit_bloc.dart';

class AccountEditPhoneField extends StatelessWidget {
  const AccountEditPhoneField({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final AccountEditNormalFormCubit cubit = AccountEditNormalFormCubit();

    return TextFormField(
      decoration: InputDecoration(
        labelText: "${appLocalizations.phone}${appLocalizations.fieldOptional}",
      ),
      keyboardType: TextInputType.phone,
      inputFormatters: [
        FilteringTextInputFormatter.singleLineFormatter,
        FilteringTextInputFormatter.digitsOnly,
      ],
      onSaved: (value) => cubit.displayName = value,
    );
  }
}