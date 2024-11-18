part of '../theme_manager.dart';

class _BrightnessCard extends StatelessWidget {
  const _BrightnessCard();

  @override
  Widget build(BuildContext context) {
    return const SettingsCard(
      padding: EdgeInsets.fromLTRB(24.0, 8.0, 24.0, 24.0),
      child: Column(
        children: [
          _BrightnessCardTitle(),
          _BrightnessSwitcher(),
        ],
      ),
    );
  }
}
