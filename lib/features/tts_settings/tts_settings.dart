import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../enum/tts_service_state.dart';
import '../../generated/i18n/app_localizations.dart';
import '../../utils/language_code_utils.dart';
import '../common_components/common_back_button.dart';
import 'cubit/tts_settings_cubit.dart';

part 'dialog/language_select_dialog.dart';
part 'widgets/demo_section.dart';
part 'widgets/slider.dart';

class TtsSettings extends StatelessWidget {
  const TtsSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TtsSettingsCubit(),
      child: const _PageScaffold(),
    );
  }
}

class _PageScaffold extends StatelessWidget {
  const _PageScaffold();

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final cubit = BlocProvider.of<TtsSettingsCubit>(context);
    return Scaffold(
      appBar: AppBar(
        leading: const CommonBackButton(),
        title: Text(appLocalizations.ttsSettingsTitle),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const _DemoSection(),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
              ),
              child: ListTile(
                leading: const Icon(Icons.language),
                title: Text(appLocalizations.ttsSettingsSelectLanguage),
                subtitle: BlocBuilder<TtsSettingsCubit, TtsSettingsState>(
                  buildWhen: (previous, current) =>
                      previous.ttsState != current.ttsState ||
                      previous.languageCode != current.languageCode,
                  builder: (context, state) {
                    return Text(
                      LanguageCodeUtils.getName(
                        context,
                        state.languageCode,
                      ),
                    );
                  },
                ),
                onTap: () async {
                  final languageCode = await showDialog<String>(
                    context: context,
                    builder: (_) => _LanguageSelectDialog(
                      languageCodeList: cubit.state.languageList,
                    ),
                  );
                  if (languageCode != null) {
                    cubit.setLanguageCode(languageCode);
                  }
                },
              ),
            ),
            _Slider(
              title: appLocalizations.ttsSettingsPitch,
              buildWhen: (previous, current) =>
                  previous.ttsState != current.ttsState ||
                  previous.pitch != current.pitch,
              onChanged: cubit.setPitch,
              min: 0.5,
              max: 2.0,
              divisions: 15,
              valueSelector: (state) => state.pitch,
            ),
            _Slider(
              title: appLocalizations.ttsSettingsVolume,
              buildWhen: (previous, current) =>
                  previous.ttsState != current.ttsState ||
                  previous.volume != current.volume,
              onChanged: cubit.setVolume,
              min: 0.0,
              max: 1.0,
              divisions: 10,
              valueSelector: (state) => state.volume,
            ),
            _Slider(
              title: appLocalizations.ttsSettingsSpeechRate,
              buildWhen: (previous, current) =>
                  previous.ttsState != current.ttsState ||
                  previous.speechRate != current.speechRate,
              onChanged: cubit.setSpeechRate,
              min: 0.5,
              max: 2.0,
              divisions: 15,
              valueSelector: (state) => state.speechRate,
            ),
          ],
        ),
      ),
    );
  }
}
