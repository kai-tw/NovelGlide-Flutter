part of '../reader.dart';

class _Pagination extends StatelessWidget {
  const _Pagination();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<_ReaderCubit, _ReaderState>(
      buildWhen: (previous, current) =>
          previous.chapterCurrentPage != current.chapterCurrentPage ||
          previous.chapterTotalPage != current.chapterTotalPage ||
          previous.percentage != current.percentage,
      builder: (context, state) {
        return Text('${state.chapterCurrentPage} / ${state.chapterTotalPage}');
        // return LinearProgressIndicator(value: state.percentage);
      },
    );
  }
}
