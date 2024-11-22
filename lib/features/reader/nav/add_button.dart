part of '../reader.dart';

/// Add bookmark button
class _AddButton extends StatefulWidget {
  const _AddButton();

  @override
  State<_AddButton> createState() => _State();
}

class _State extends State<_AddButton> {
  CommonButtonStateCode _stateCode = CommonButtonStateCode.disabled;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final isIdle = _stateCode == CommonButtonStateCode.idle;
    final isLoading = _stateCode == CommonButtonStateCode.loading;
    final isSuccess = _stateCode == CommonButtonStateCode.success;
    return BlocListener<_ReaderCubit, _ReaderState>(
      listenWhen: (previous, current) =>
          previous.readerSettings.autoSave != current.readerSettings.autoSave ||
          previous.code != current.code ||
          previous.bookmarkData != current.bookmarkData ||
          previous.startCfi != current.startCfi,
      listener: (_, readerState) {
        if (isLoading || isSuccess) {
          return;
        }
        _resetState(readerState);
      },
      child: IconButton(
        icon: Icon(
          isSuccess ? Icons.check_rounded : Icons.bookmark_add_rounded,
          semanticLabel: appLocalizations.accessibilityReaderAddBookmarkButton,
        ),
        style: IconButton.styleFrom(
          disabledForegroundColor: isSuccess ? Colors.green : null,
        ),
        onPressed: isIdle ? _onPressed : null,
      ),
    );
  }

  void _onPressed() async {
    _stateCode = CommonButtonStateCode.loading;
    setState(() => _stateCode = CommonButtonStateCode.loading);

    await BlocProvider.of<_ReaderCubit>(context).saveBookmark();
    if (mounted) {
      setState(() => _stateCode = CommonButtonStateCode.success);
    }

    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      _resetState();
    }
  }

  void _resetState([_ReaderState? readerState]) {
    readerState ??= BlocProvider.of<_ReaderCubit>(context).state;
    final isAutoSave = readerState.readerSettings.autoSave;

    if (readerState.code.isLoaded && !isAutoSave) {
      setState(() => _stateCode = CommonButtonStateCode.idle);
    } else {
      setState(() => _stateCode = CommonButtonStateCode.disabled);
    }
  }
}
