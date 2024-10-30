import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../enum/common_button_state_code.dart';
import '../../../enum/loading_state_code.dart';
import '../bloc/reader_cubit.dart';
import '../bloc/reader_state.dart';

class ReaderAddBookmarkButton extends StatefulWidget {
  const ReaderAddBookmarkButton({super.key});

  @override
  State<ReaderAddBookmarkButton> createState() => _State();
}

class _State extends State<ReaderAddBookmarkButton> {
  CommonButtonStateCode _stateCode = CommonButtonStateCode.disabled;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final isIdle = _stateCode == CommonButtonStateCode.idle;
    final isLoading = _stateCode == CommonButtonStateCode.loading;
    final isSuccess = _stateCode == CommonButtonStateCode.success;
    return BlocListener<ReaderCubit, ReaderState>(
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

    await BlocProvider.of<ReaderCubit>(context).saveBookmark();
    if (mounted) {
      setState(() => _stateCode = CommonButtonStateCode.success);
    }

    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      _resetState();
    }
  }

  void _resetState([ReaderState? readerState]) {
    readerState ??= BlocProvider.of<ReaderCubit>(context).state;
    final isLoaded = readerState.code == LoadingStateCode.loaded;
    final isAutoSave = readerState.readerSettings.autoSave;
    final isBookmarked =
        readerState.bookmarkData?.startCfi == readerState.startCfi;

    if (isLoaded && !isAutoSave && !isBookmarked) {
      setState(() => _stateCode = CommonButtonStateCode.idle);
    } else {
      setState(() => _stateCode = CommonButtonStateCode.disabled);
    }
  }
}
