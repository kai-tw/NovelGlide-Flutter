part of '../reader.dart';

class _Breadcrumb extends StatelessWidget {
  const _Breadcrumb();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReaderCubit, ReaderState>(
      buildWhen: (ReaderState previous, ReaderState current) =>
          previous.breadcrumb != current.breadcrumb,
      builder: (BuildContext context, ReaderState state) {
        return Text(
          state.breadcrumb,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
          overflow: TextOverflow.ellipsis,
        );
      },
    );
  }
}
