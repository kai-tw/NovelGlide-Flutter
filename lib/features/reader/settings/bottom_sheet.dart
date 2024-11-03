part of '../reader.dart';

class _BottomSheet extends StatelessWidget {
  const _BottomSheet();

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.5,
      minChildSize: 0.25,
      maxChildSize: 0.8,
      expand: false,
      snap: true,
      snapSizes: const [0.25, 0.5, 0.8],
      builder: (context, scrollController) {
        return SingleChildScrollView(
          controller: scrollController,
          child: const Column(
            children: [
              _SettingsCard(
                children: [
                  _SettingsFontSizeSlider(),
                  _SettingsLineHeightSlider(),
                ],
              ),
              _SettingsCard(
                children: [
                  _SettingsAutoSaveSwitch(),
                  _SettingsGestureSwitcher(),
                ],
              ),
              _SettingsCard(
                children: [
                  _SettingsResetButton(),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
