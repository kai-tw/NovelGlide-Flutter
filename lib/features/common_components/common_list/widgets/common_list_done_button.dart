part of '../common_list.dart';

class CommonListDoneButton extends StatelessWidget {
  final bool isVisible;
  final void Function()? onPressed;

  const CommonListDoneButton({
    super.key,
    this.isVisible = true,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    Widget? child;

    if (isVisible) {
      child = TextButton(
        onPressed: onPressed,
        child: Text(appLocalizations.generalDone),
      );
    }

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (child, animation) =>
          FadeTransition(opacity: animation, child: child),
      child: child,
    );
  }
}
