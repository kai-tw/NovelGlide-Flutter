import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../generated/i18n/app_localizations.dart';
import '../../../utils/route_utils.dart';
import '../../tts_settings/tts_settings.dart';
import '../cubit/reader_cubit.dart';

class ReaderTtsSettingsButton extends StatelessWidget {
  const ReaderTtsSettingsButton({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return BlocBuilder<ReaderCubit, ReaderState>(
      buildWhen: (previous, current) => previous.ttsState != current.ttsState,
      builder: (context, state) {
        final isEnabled = state.ttsState.isStopped;
        return IconButton(
          icon: const Icon(Icons.settings_rounded),
          tooltip: appLocalizations.ttsSettingsTitle,
          onPressed: isEnabled ? () => _navigateToTtsSettings(context) : null,
        );
      },
    );
  }

  void _navigateToTtsSettings(BuildContext context) {
    final cubit = BlocProvider.of<ReaderCubit>(context);
    Navigator.of(context)
        .push(RouteUtils.pushRoute(const TtsSettings()))
        .then((_) => cubit.ttsHandler.reload());
  }
}
