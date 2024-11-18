part of '../theme_manager.dart';

class _ThemeCard extends StatelessWidget {
  const _ThemeCard();

  @override
  Widget build(BuildContext context) {
    return const SettingsCard(
      padding: EdgeInsets.fromLTRB(24.0, 8.0, 24.0, 16.0),
      child: Column(
        children: [
          _ThemeCardTitle(),
          _ThemeGrid(),
        ],
      ),
    );
  }
}
