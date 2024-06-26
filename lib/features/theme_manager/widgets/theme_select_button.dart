import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';

import '../../../data/theme_data_record.dart';
import '../../../data/theme_id.dart';
import '../../theme/theme_template.dart';
import '../../../processor/theme_processor.dart';

class ThemeSelectButton extends StatelessWidget {
  const ThemeSelectButton({super.key, required this.themeId});

  final ThemeId themeId;

  @override
  Widget build(BuildContext context) {
    final String? themeName = ThemeProcessor.getThemeNameById(context, themeId);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ThemeSwitcher.withTheme(
          builder: (context, _, currentTheme) {
            return OutlinedButton(
              onPressed: () => ThemeProcessor.switchTheme(context, id: themeId),
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                backgroundColor: currentTheme.colorScheme.surface,
                foregroundColor: currentTheme.colorScheme.onSurface,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Text("Aa", overflow: TextOverflow.ellipsis),
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(themeName ?? "Aa", overflow: TextOverflow.ellipsis),
        ),
      ],
    );
  }
}
