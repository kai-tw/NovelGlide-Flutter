part of 'bookshelf.dart';

class BookshelfAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BookshelfAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final double windowWidth = MediaQuery.sizeOf(context).width;
    final WindowClass windowClass = WindowClass.fromWidth(windowWidth);

    switch (windowClass) {
      case WindowClass.compact:
        return const BookshelfCompactAppBar();

      default:
        return const BookshelfMediumAppBar();
    }
  }
}
