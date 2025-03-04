part of '../tts_settings.dart';

class _VoiceSelectDialog extends StatelessWidget {
  final List<TtsVoiceData> voiceList;

  const _VoiceSelectDialog({required this.voiceList});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return Dialog(
      clipBehavior: Clip.hardEdge,
      child: Scaffold(
        appBar: AppBar(
          leading: const CommonBackButton(),
          title: Text(appLocalizations.ttsSettingsSelectVoice),
        ),
        body: Scrollbar(
          child: ListView.builder(
            itemCount: voiceList.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(voiceList[index].name),
                subtitle: Text(voiceList[index].getLocaleName(context)),
                onTap: () {
                  Navigator.of(context).pop(voiceList[index]);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
