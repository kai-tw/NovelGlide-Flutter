part of '../reader.dart';

class _ChapterTitle extends StatelessWidget {
  const _ChapterTitle();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<_ReaderCubit, _ReaderState>(
      buildWhen: (previous, current) =>
          previous.chapterTitle != current.chapterTitle,
      builder: (context, state) {
        return Text(
          state.chapterTitle,
          style: Theme.of(context).textTheme.titleSmall,
        );
      },
    );
  }
}
