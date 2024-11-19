part of '../reader.dart';

class _Pagination extends StatelessWidget {
  const _Pagination();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<_ReaderCubit, _ReaderState>(
      buildWhen: (previous, current) =>
          previous.localCurrent != current.localCurrent ||
          previous.localTotal != current.localTotal,
      builder: (context, state) {
        return Text(
          "${state.localCurrent} / ${state.localTotal}",
          style: Theme.of(context).textTheme.labelMedium,
        );
      },
    );
  }
}
