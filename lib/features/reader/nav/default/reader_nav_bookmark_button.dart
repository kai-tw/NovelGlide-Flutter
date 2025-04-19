part of 'reader_default_navigation.dart';

class ReaderNavBookmarkButton extends StatefulWidget {
  const ReaderNavBookmarkButton({super.key});

  @override
  State<ReaderNavBookmarkButton> createState() => _State();
}

class _State extends State<ReaderNavBookmarkButton> {
  CommonButtonStateCode _stateCode = CommonButtonStateCode.disabled;

  @override
  void initState() {
    super.initState();
    _resetState();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return BlocListener<ReaderCubit, ReaderState>(
      listenWhen: (previous, current) =>
          previous.readerSettings.isAutoSaving !=
              current.readerSettings.isAutoSaving ||
          previous.code != current.code ||
          previous.bookmarkData != current.bookmarkData ||
          previous.startCfi != current.startCfi ||
          previous.ttsState != current.ttsState,
      listener: (_, readerState) {
        if (_stateCode.isLoading || _stateCode.isSuccess) {
          return;
        }
        _resetState();
      },
      child: IconButton(
        icon: Icon(
          _stateCode.isSuccess
              ? Icons.check_rounded
              : Icons.bookmark_add_rounded,
        ),
        tooltip: appLocalizations.readerBookmark,
        style: IconButton.styleFrom(
          disabledForegroundColor: _stateCode.isSuccess ? Colors.green : null,
        ),
        onPressed: _stateCode.isIdle ? _onPressed : null,
      ),
    );
  }

  void _onPressed() async {
    setState(() => _stateCode = CommonButtonStateCode.loading);

    BlocProvider.of<ReaderCubit>(context).saveBookmark();
    setState(() => _stateCode = CommonButtonStateCode.success);

    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      _resetState();
    }
  }

  void _resetState() {
    final readerState = BlocProvider.of<ReaderCubit>(context).state;

    if (readerState.code.isLoaded &&
        readerState.bookmarkData?.startCfi != readerState.startCfi &&
        !readerState.readerSettings.isAutoSaving &&
        readerState.ttsState.isStopped) {
      setState(() => _stateCode = CommonButtonStateCode.idle);
    } else {
      setState(() => _stateCode = CommonButtonStateCode.disabled);
    }
  }
}
