part of '../../tts_service.dart';

class _VoiceSelectDialog extends StatelessWidget {
  const _VoiceSelectDialog({required this.voiceList});

  final List<TtsVoiceData> voiceList;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return Dialog(
      clipBehavior: Clip.hardEdge,
      child: Scaffold(
        appBar: AppBar(
          title: Text(appLocalizations.ttsSettingsSelectVoice),
        ),
        body: Scrollbar(
          child: ListView.builder(
            itemCount: voiceList.length,
            itemBuilder: (BuildContext context, int index) {
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
