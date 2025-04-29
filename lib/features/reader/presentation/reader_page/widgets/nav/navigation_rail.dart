part of '../../reader.dart';

class ReaderNavigationRail extends StatelessWidget {
  const ReaderNavigationRail({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 64.0,
      child: BlocBuilder<ReaderCubit, ReaderState>(
        builder: (BuildContext context, ReaderState state) {
          switch (state.navigationStateCode) {
            case ReaderNavigationStateCode.ttsState:
              return const Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  ReaderTtsSettingsButton(),
                  ReaderTtsCloseButton(),
                  ReaderTtsPlayPauseButton(),
                  ReaderTtsStopButton(),
                ],
              );

            default:
              return const Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  ReaderNavSettingsButton(),
                  ReaderNavTtsButton(),
                  ReaderNavBookmarkButton(),
                  ReaderNavPreviousButton(),
                  ReaderNavNextButton(),
                ],
              );
          }
        },
      ),
    );
  }
}
