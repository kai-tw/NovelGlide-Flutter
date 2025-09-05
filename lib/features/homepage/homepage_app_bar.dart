part of 'homepage.dart';

class HomepageAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomepageAppBar({
    super.key,
    required this.leading,
    required this.title,
    this.actions,
  });

  final Widget leading;
  final String title;
  final List<Widget>? actions;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final WindowSize windowClass = WindowSize.of(context);

    return AppBar(
      leading: leading,
      leadingWidth: windowClass == WindowSize.compact ? null : 100.0,
      title: Text(title),
      actions: actions,
    );
  }
}
