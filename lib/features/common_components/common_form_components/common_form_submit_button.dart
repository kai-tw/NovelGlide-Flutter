import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../common_processing.dart';

class CommonFormSubmitButton extends StatelessWidget {
  const CommonFormSubmitButton(
      {super.key, this.iconData, this.labelText, this.onPressed, this.onSuccess, this.onFailed});

  final IconData? iconData;
  final String? labelText;
  final Future<bool> Function()? onPressed;
  final void Function()? onSuccess;
  final void Function(dynamic e)? onFailed;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 24.0),
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      icon: Icon(iconData ?? Icons.send_rounded),
      label: Text(
        labelText ?? appLocalizations.submit,
        style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
      ),
      onPressed: () {
        if (onPressed != null && Form.of(context).validate()) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => const Dialog(
              child: CommonProcessing(),
            ),
          );
          Form.of(context).save();
          onPressed!().then((bool isSuccess) {
            Navigator.of(context, rootNavigator: true).pop();

            if (isSuccess && onSuccess != null) {
              onSuccess!();
            } else if (onFailed != null) {
              onFailed!(null);
            }
          }).catchError((e) {
            Navigator.of(context, rootNavigator: true).pop();
            if (onFailed != null) {
              onFailed!(e);
            }
          });
        }
      },
    );
  }
}
