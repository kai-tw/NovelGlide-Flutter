part of '../reader.dart';

class _Pagination extends StatelessWidget {
  const _Pagination();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<_ReaderCubit, _ReaderState>(
      buildWhen: (previous, current) =>
          previous.percentage != current.percentage,
      builder: (context, state) {
        return LinearProgressIndicator(value: state.percentage);
      },
    );
  }
}
