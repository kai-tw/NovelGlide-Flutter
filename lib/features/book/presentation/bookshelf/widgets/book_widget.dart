part of '../bookshelf.dart';

class _BookWidget extends StatelessWidget {
  const _BookWidget({required this.bookData});

  final BookData bookData;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: AspectRatio(
            aspectRatio: 1 / 1.5,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(16.0),
              ),
              clipBehavior: Clip.hardEdge,
              child: BookCoverImage(
                bookData: bookData,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Text(
          bookData.name,
          maxLines: 3,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
