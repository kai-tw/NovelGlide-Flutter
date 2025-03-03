part of '../tts_settings.dart';

class _VoiceSelectDialog extends StatelessWidget {
  final List<TtsVoiceData> voiceList;

  const _VoiceSelectDialog({required this.voiceList});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return Dialog(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              appLocalizations.ttsSettingsSelectVoice,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: voiceList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(voiceList[index].name),
                  subtitle: Text(
                    TtsUtils.getNameFromLanguageCode(
                      context,
                      voiceList[index].locale,
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).pop(voiceList[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
