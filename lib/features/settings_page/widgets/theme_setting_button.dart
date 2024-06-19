import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../theme_manager/theme_manager.dart';

class ThemeSettingButton extends StatelessWidget {
  const ThemeSettingButton({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return TextButton(
      onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ThemeManager())),
      style: TextButton.styleFrom(
        padding: const EdgeInsets.all(16.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
      ),
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Icon(
              Icons.format_paint_rounded,
              size: 24,
            ),
          ),
          Text(appLocalizations.themeTitle),
        ],
      ),
    );
  }
}
