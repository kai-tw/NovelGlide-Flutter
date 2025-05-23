part of '../tts_service.dart';

class TtsVoiceData {
  TtsVoiceData({
    required this.name,
    required this.locale,
  });

  factory TtsVoiceData.fromJson(String json) {
    final Map<String, dynamic> map = jsonDecode(json) as Map<String, dynamic>;
    return TtsVoiceData(
      name: map['name'] as String,
      locale: map['locale'] as String,
    );
  }

  String name;
  String locale;

  String toJson() {
    return jsonEncode(toMap());
  }

  Map<String, String> toMap() {
    return <String, String>{
      'name': name,
      'locale': locale,
    };
  }

  @override
  String toString() {
    return 'TtsVoiceData(name: $name, locale: $locale)';
  }

  String getLocaleName(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    switch (locale) {
      case 'ar':
        return appLocalizations.languageCodeAr;
      case 'ar-001':
        return appLocalizations.languageCodeAr001;
      case 'as-IN':
        return appLocalizations.languageCodeAsIN;
      case 'bg-BG':
        return appLocalizations.languageCodeBgBG;
      case 'bn-BD':
        return appLocalizations.languageCodeBnBD;
      case 'bn-IN':
        return appLocalizations.languageCodeBnIN;
      case 'brx-IN':
        return appLocalizations.languageCodeBrxIN;
      case 'bs-BA':
        return appLocalizations.languageCodeBsBA;
      case 'ca-ES':
        return appLocalizations.languageCodeCaES;
      case 'cs-CZ':
        return appLocalizations.languageCodeCsCZ;
      case 'cy-GB':
        return appLocalizations.languageCodeCyGB;
      case 'da-DK':
        return appLocalizations.languageCodeDaDK;
      case 'de-DE':
        return appLocalizations.languageCodeDeDE;
      case 'doi-IN':
        return appLocalizations.languageCodeDoiIN;
      case 'el-GR':
        return appLocalizations.languageCodeElGR;
      case 'en-AU':
        return appLocalizations.languageCodeEnAU;
      case 'en-GB':
        return appLocalizations.languageCodeEnGB;
      case 'en-IE':
        return appLocalizations.languageCodeEnIe;
      case 'en-IN':
        return appLocalizations.languageCodeEnIN;
      case 'en-NG':
        return appLocalizations.languageCodeEnNG;
      case 'en-US':
        return appLocalizations.languageCodeEnUS;
      case 'en-ZA':
        return appLocalizations.languageCodeEnZa;
      case 'es-ES':
        return appLocalizations.languageCodeEsES;
      case 'es-MX':
        return appLocalizations.languageCodeEsMx;
      case 'es-US':
        return appLocalizations.languageCodeEsUS;
      case 'et-EE':
        return appLocalizations.languageCodeEtEE;
      case 'fi-FI':
        return appLocalizations.languageCodeFiFI;
      case 'fil-PH':
        return appLocalizations.languageCodeFilPH;
      case 'fr-CA':
        return appLocalizations.languageCodeFrCA;
      case 'fr-FR':
        return appLocalizations.languageCodeFrFR;
      case 'gu-IN':
        return appLocalizations.languageCodeGuIN;
      case 'he-IL':
        return appLocalizations.languageCodeHeIL;
      case 'hi-IN':
        return appLocalizations.languageCodeHiIN;
      case 'hr-HR':
        return appLocalizations.languageCodeHrHR;
      case 'hu-HU':
        return appLocalizations.languageCodeHuHU;
      case 'id-ID':
        return appLocalizations.languageCodeIdID;
      case 'is-IS':
        return appLocalizations.languageCodeIsIS;
      case 'it-IT':
        return appLocalizations.languageCodeItIT;
      case 'ja-JP':
        return appLocalizations.languageCodeJaJP;
      case 'jv-ID':
        return appLocalizations.languageCodeJvID;
      case 'km-KH':
        return appLocalizations.languageCodeKmKH;
      case 'kn-IN':
        return appLocalizations.languageCodeKnIN;
      case 'kok-IN':
        return appLocalizations.languageCodeKokIN;
      case 'ko-KR':
        return appLocalizations.languageCodeKoKR;
      case 'ks-IN':
        return appLocalizations.languageCodeKsIN;
      case 'lt-LT':
        return appLocalizations.languageCodeLtLT;
      case 'lv-LV':
        return appLocalizations.languageCodeLvLV;
      case 'mai-IN':
        return appLocalizations.languageCodeMaiIN;
      case 'ml-IN':
        return appLocalizations.languageCodeMlIN;
      case 'mni-IN':
        return appLocalizations.languageCodeMniIN;
      case 'mr-IN':
        return appLocalizations.languageCodeMrIN;
      case 'ms-MY':
        return appLocalizations.languageCodeMsMY;
      case 'nb-NO':
        return appLocalizations.languageCodeNbNO;
      case 'ne-NP':
        return appLocalizations.languageCodeNeNP;
      case 'nl-BE':
        return appLocalizations.languageCodeNlBE;
      case 'nl-NL':
        return appLocalizations.languageCodeNlNL;
      case 'or-IN':
        return appLocalizations.languageCodeOrIN;
      case 'pa-IN':
        return appLocalizations.languageCodePaIN;
      case 'pl-PL':
        return appLocalizations.languageCodePlPL;
      case 'pt-BR':
        return appLocalizations.languageCodePtBR;
      case 'pt-PT':
        return appLocalizations.languageCodePtPT;
      case 'ro-RO':
        return appLocalizations.languageCodeRoRO;
      case 'ru-RU':
        return appLocalizations.languageCodeRuRU;
      case 'sa-IN':
        return appLocalizations.languageCodeSaIN;
      case 'sat-IN':
        return appLocalizations.languageCodeSatIN;
      case 'sd-IN':
        return appLocalizations.languageCodeSdIN;
      case 'si-LK':
        return appLocalizations.languageCodeSiLK;
      case 'sk-SK':
        return appLocalizations.languageCodeSkSK;
      case 'sl-SI':
        return appLocalizations.languageCodeSlSI;
      case 'sq-AL':
        return appLocalizations.languageCodeSqAL;
      case 'sr-RS':
        return appLocalizations.languageCodeSrRS;
      case 'su-ID':
        return appLocalizations.languageCodeSuID;
      case 'sv-SE':
        return appLocalizations.languageCodeSvSE;
      case 'sw-KE':
        return appLocalizations.languageCodeSwKE;
      case 'ta-IN':
        return appLocalizations.languageCodeTaIN;
      case 'te-IN':
        return appLocalizations.languageCodeTeIN;
      case 'th-TH':
        return appLocalizations.languageCodeThTH;
      case 'tr-TR':
        return appLocalizations.languageCodeTrTR;
      case 'uk-UA':
        return appLocalizations.languageCodeUkUA;
      case 'ur-IN':
        return appLocalizations.languageCodeUrIN;
      case 'ur-PK':
        return appLocalizations.languageCodeUrPK;
      case 'vi-VN':
        return appLocalizations.languageCodeViVN;
      case 'yue-HK':
        return appLocalizations.languageCodeYueHK;
      case 'zh-CN':
        return appLocalizations.languageCodeZhCN;
      case 'zh-HK':
        return appLocalizations.languageCodeZhHk;
      case 'zh-TW':
        return appLocalizations.languageCodeZhTW;
      default:
        return appLocalizations.languageCodeUnknown(locale);
    }
  }
}
