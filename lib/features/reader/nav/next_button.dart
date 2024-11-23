part of '../reader.dart';

/// Next chapter button
class _NextButton extends StatelessWidget {
  const _NextButton();

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<ReaderCubit>(context);
    return BlocBuilder<ReaderCubit, ReaderState>(
      buildWhen: (previous, current) => previous.code != current.code,
      builder: (BuildContext context, ReaderState state) {
        final isDisabled = state.code != LoadingStateCode.loaded;
        return IconButton(
          icon: Icon(
            Icons.arrow_forward_ios_rounded,
            semanticLabel: AppLocalizations.of(context)!
                .accessibilityReaderNextChapterButton,
          ),
          onPressed: isDisabled
              ? null
              : () => cubit.state.isRtl ? cubit.prevPage() : cubit.nextPage(),
        );
      },
    );
  }
}
