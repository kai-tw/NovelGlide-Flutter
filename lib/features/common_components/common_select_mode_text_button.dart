import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CommonSelectModeTextButton extends StatelessWidget {
  final bool isEmpty;
  final bool isSelectAll;
  final void Function() selectAll;
  final void Function() deselectAll;

  const CommonSelectModeTextButton({
    super.key,
    required this.isEmpty,
    required this.isSelectAll,
    required this.selectAll,
    required this.deselectAll,
  });

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    if (isEmpty) {
      return TextButton(
        onPressed: null,
        child: Text(appLocalizations.generalSelectAll),
      );
    } else {
      return TextButton(
        onPressed: () => isSelectAll ? deselectAll() : selectAll(),
        child: Text(isSelectAll
            ? appLocalizations.generalDeselectAll
            : appLocalizations.generalSelectAll),
      );
    }
  }
}
