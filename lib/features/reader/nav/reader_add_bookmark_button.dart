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
    return BlocListener<ReaderCubit, ReaderState>(
      listenWhen: (previous, current) =>
          previous.readerSettings.autoSave != current.readerSettings.autoSave ||
          previous.code != current.code,
      listener: (context, readerState) {
        if (readerState.code == LoadingStateCode.loaded &&
            !readerState.readerSettings.autoSave) {
          setState(() => _stateCode = CommonButtonStateCode.idle);
        } else {
          setState(() => _stateCode = CommonButtonStateCode.disabled);
        }
      },
      child: IconButton(
        icon: Icon(
          Icons.bookmark_add_rounded,
          semanticLabel: appLocalizations.accessibilityReaderAddBookmarkButton,
        ),
        selectedIcon: const Icon(Icons.check_rounded, color: Colors.green),
        isSelected: _stateCode == CommonButtonStateCode.success,
        onPressed: _stateCode == CommonButtonStateCode.idle ? _onPressed : null,
      ),
    );
  }

  void _onPressed() async {
    BlocProvider.of<ReaderCubit>(context).saveBookmark();

    setState(() => _stateCode = CommonButtonStateCode.success);
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      setState(() => _stateCode = CommonButtonStateCode.idle);
    }
  }
}
