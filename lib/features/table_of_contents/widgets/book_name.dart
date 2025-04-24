part of '../table_of_contents.dart';

class _BookName extends StatelessWidget {
  const _BookName({required this.bookData});

  final BookData bookData;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.9),
        borderRadius: const BorderRadius.all(Radius.circular(16.0)),
      ),
      clipBehavior: Clip.hardEdge,
      child: Text(
        bookData.name,
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.onSurface,
        ),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
