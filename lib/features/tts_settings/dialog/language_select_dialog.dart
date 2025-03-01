part of '../tts_settings.dart';

class _LanguageSelectDialog extends StatelessWidget {
  final List<String> languageCodeList;

  const _LanguageSelectDialog({required this.languageCodeList});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return Dialog(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              appLocalizations.ttsSettingsSelectLanguage,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: languageCodeList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    LanguageCodeUtils.getName(
                      context,
                      languageCodeList[index],
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).pop(languageCodeList[index]);
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
