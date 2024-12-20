part of '../reader.dart';

/// Previous chapter button
class _PreviousButton extends StatelessWidget {
  const _PreviousButton();

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<ReaderCubit>(context);
    return BlocBuilder<ReaderCubit, ReaderState>(
      buildWhen: (previous, current) => previous.code != current.code,
      builder: (BuildContext context, ReaderState state) {
        final isDisabled = state.code != LoadingStateCode.loaded;
        return IconButton(
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            semanticLabel: AppLocalizations.of(context)!
                .accessibilityReaderPrevChapterButton,
          ),
          onPressed: isDisabled
              ? null
              : () => cubit.state.isRtl ? cubit.nextPage() : cubit.prevPage(),
        );
      },
    );
  }
}
