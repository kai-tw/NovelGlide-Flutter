part of '../../reader.dart';

class ReaderNavigationBar extends StatelessWidget {
  const ReaderNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 64.0,
      child: BlocBuilder<ReaderCubit, ReaderState>(
        builder: (BuildContext context, ReaderState state) {
          switch (state.navigationStateCode) {
            case ReaderNavigationStateCode.ttsState:
              return const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ReaderTtsPlayPauseButton(),
                  ReaderTtsStopButton(),
                  ReaderTtsCloseButton(),
                  ReaderTtsSettingsButton(),
                ],
              );

            default:
              return const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ReaderNavPreviousButton(),
                  ReaderNavNextButton(),
                  ReaderNavBookmarkButton(),
                  ReaderNavTtsButton(),
                  ReaderNavSettingsButton(),
                ],
              );
          }
        },
      ),
    );
  }
}
