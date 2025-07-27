part of '../../settings_service.dart';

class SettingsCard extends StatelessWidget {
  const SettingsCard({
    super.key,
    required this.child,
    this.margin,
    this.padding,
  });

  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: margin ??
          const EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 16.0,
          ),
      color: Theme.of(context).colorScheme.surfaceContainer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.0),
      ),
      child: Padding(
        padding: padding ??
            const EdgeInsets.symmetric(
              vertical: 24.0,
              horizontal: 24.0,
            ),
        child: child,
      ),
    );
  }
}
