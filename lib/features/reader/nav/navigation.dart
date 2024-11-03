part of '../reader.dart';

class _NavigationBar extends StatelessWidget {
  const _NavigationBar();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 64.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _PreviousButton(),
          _NextButton(),
          _JumpToButton(),
          _AddButton(),
          _SettingsButton(),
        ],
      ),
    );
  }
}

class _NavigationRail extends StatelessWidget {
  const _NavigationRail();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 64.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _SettingsButton(),
          _JumpToButton(),
          _AddButton(),
          _PreviousButton(),
          _NextButton(),
        ],
      ),
    );
  }
}
