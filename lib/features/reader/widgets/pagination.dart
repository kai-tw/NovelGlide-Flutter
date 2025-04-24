part of '../reader.dart';

class _Pagination extends StatelessWidget {
  const _Pagination();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReaderCubit, ReaderState>(
      buildWhen: (ReaderState prev, ReaderState curr) =>
          prev.readerSettings.pageNumType != curr.readerSettings.pageNumType ||
          curr.readerSettings.pageNumType != ReaderSettingsPageNumType.hidden &&
              prev.chapterCurrentPage != curr.chapterCurrentPage ||
          prev.chapterTotalPage != curr.chapterTotalPage,
      builder: (BuildContext context, ReaderState state) {
        switch (state.readerSettings.pageNumType) {
          case ReaderSettingsPageNumType.hidden:
            return const SizedBox();

          case ReaderSettingsPageNumType.number:
            return Text(
                '${state.chapterCurrentPage} / ${state.chapterTotalPage}');

          case ReaderSettingsPageNumType.percentage:
            final num percentage =
                (state.chapterCurrentPage / state.chapterTotalPage * 100)
                    .clamp(0, 100);
            return Text('${percentage.toStringAsFixed(1)}%');

          case ReaderSettingsPageNumType.progressBar:
            final double percentage =
                state.chapterCurrentPage / state.chapterTotalPage;
            return LinearProgressIndicator(value: percentage);
        }
      },
    );
  }
}
