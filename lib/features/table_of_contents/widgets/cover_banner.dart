part of '../table_of_contents.dart';

class _CoverBanner extends StatelessWidget {
  final BookData bookData;

  const _CoverBanner({required this.bookData});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          width: constraints.maxWidth,
          height: constraints.maxHeight,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            borderRadius: const BorderRadius.all(Radius.circular(24.0)),
          ),
          clipBehavior: Clip.hardEdge,
          child: CommonBookCoverImage(bookData: bookData),
        );
      },
    );
  }
}
