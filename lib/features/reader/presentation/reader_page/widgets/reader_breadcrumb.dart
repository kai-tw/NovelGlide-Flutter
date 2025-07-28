part of '../reader.dart';

class ReaderBreadcrumb extends StatelessWidget {
  const ReaderBreadcrumb({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReaderCubit, ReaderState>(
      buildWhen: (ReaderState previous, ReaderState current) =>
          previous.breadcrumb != current.breadcrumb,
      builder: (BuildContext context, ReaderState state) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
          ),
          child: Text(
            state.breadcrumb,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Theme.of(context).colorScheme.tertiary,
                ),
            overflow: TextOverflow.ellipsis,
          ),
        );
      },
    );
  }
}
