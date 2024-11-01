part of '../common_list.dart';

class CommonListSelectButton extends StatelessWidget {
  final bool isVisible;
  final bool enabled;
  final bool isSelectAll;
  final void Function() selectAll;
  final void Function() deselectAll;

  const CommonListSelectButton({
    super.key,
    this.isVisible = true,
    required this.enabled,
    required this.isSelectAll,
    required this.selectAll,
    required this.deselectAll,
  });

  @override
  Widget build(BuildContext context) {
    Widget? child;

    if (isVisible) {
      final appLocalizations = AppLocalizations.of(context)!;
      if (enabled) {
        return TextButton(
          onPressed: isSelectAll ? deselectAll : selectAll,
          child: Text(isSelectAll
              ? appLocalizations.generalDeselectAll
              : appLocalizations.generalSelectAll),
        );
      } else {
        return TextButton(
          onPressed: null,
          child: Text(appLocalizations.generalSelectAll),
        );
      }
    }

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (child, animation) =>
          FadeTransition(opacity: animation, child: child),
      child: child,
    );
  }
}
