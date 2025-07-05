part of 'homepage.dart';

class HomepageAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomepageAppBar({
    super.key,
    required this.iconData,
    required this.title,
    this.actions,
  });

  final IconData iconData;
  final String title;
  final List<Widget>? actions;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final WindowSize windowClass = WindowSize.of(context);

    return AppBar(
      leading: Icon(iconData),
      leadingWidth: windowClass == WindowSize.compact ? null : 100.0,
      title: Text(title),
      actions: actions,
    );
  }
}
