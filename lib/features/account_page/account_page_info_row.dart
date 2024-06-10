import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AccountPageInfoRow extends StatelessWidget {
  const AccountPageInfoRow({super.key, this.iconData, this.content});

  final IconData? iconData;
  final String? content;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Icon(
              iconData ?? Icons.arrow_forward_rounded,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          Text(content ?? appLocalizations.nullValue),
        ],
      ),
    );
  }
}
