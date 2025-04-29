part of '../table_of_contents.dart';

class _CoverBanner extends StatelessWidget {
  const _CoverBanner({required this.bookData});

  final BookData bookData;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: const BorderRadius.all(Radius.circular(24.0)),
      ),
      clipBehavior: Clip.hardEdge,
      child: CommonBookCoverImage(
        bookData: bookData,
        fit: BoxFit.contain,
      ),
    );
  }
}
