import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../generated/i18n/app_localizations.dart';

class TtsVoiceData extends Equatable {
  const TtsVoiceData({
    required this.name,
    required this.locale,
  });

  final String name;
  final String locale;

  @override
  List<Object?> get props => <Object?>[name, locale];

  String getLocaleName(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return switch (locale) {
      'ar' => appLocalizations.languageCodeAr,
      'ar-001' => appLocalizations.languageCodeAr001,
      'as-IN' => appLocalizations.languageCodeAsIN,
      'bg-BG' => appLocalizations.languageCodeBgBG,
      'bn-BD' => appLocalizations.languageCodeBnBD,
      'bn-IN' => appLocalizations.languageCodeBnIN,
      'brx-IN' => appLocalizations.languageCodeBrxIN,
      'bs-BA' => appLocalizations.languageCodeBsBA,
      'ca-ES' => appLocalizations.languageCodeCaES,
      'cs-CZ' => appLocalizations.languageCodeCsCZ,
      'cy-GB' => appLocalizations.languageCodeCyGB,
      'da-DK' => appLocalizations.languageCodeDaDK,
      'de-DE' => appLocalizations.languageCodeDeDE,
      'doi-IN' => appLocalizations.languageCodeDoiIN,
      'el-GR' => appLocalizations.languageCodeElGR,
      'en-AU' => appLocalizations.languageCodeEnAU,
      'en-GB' => appLocalizations.languageCodeEnGB,
      'en-IE' => appLocalizations.languageCodeEnIe,
      'en-IN' => appLocalizations.languageCodeEnIN,
      'en-NG' => appLocalizations.languageCodeEnNG,
      'en-US' => appLocalizations.languageCodeEnUS,
      'en-ZA' => appLocalizations.languageCodeEnZa,
      'es-ES' => appLocalizations.languageCodeEsES,
      'es-MX' => appLocalizations.languageCodeEsMx,
      'es-US' => appLocalizations.languageCodeEsUS,
      'et-EE' => appLocalizations.languageCodeEtEE,
      'fi-FI' => appLocalizations.languageCodeFiFI,
      'fil-PH' => appLocalizations.languageCodeFilPH,
      'fr-CA' => appLocalizations.languageCodeFrCA,
      'fr-FR' => appLocalizations.languageCodeFrFR,
      'gu-IN' => appLocalizations.languageCodeGuIN,
      'he-IL' => appLocalizations.languageCodeHeIL,
      'hi-IN' => appLocalizations.languageCodeHiIN,
      'hr-HR' => appLocalizations.languageCodeHrHR,
      'hu-HU' => appLocalizations.languageCodeHuHU,
      'id-ID' => appLocalizations.languageCodeIdID,
      'is-IS' => appLocalizations.languageCodeIsIS,
      'it-IT' => appLocalizations.languageCodeItIT,
      'ja-JP' => appLocalizations.languageCodeJaJP,
      'jv-ID' => appLocalizations.languageCodeJvID,
      'km-KH' => appLocalizations.languageCodeKmKH,
      'kn-IN' => appLocalizations.languageCodeKnIN,
      'kok-IN' => appLocalizations.languageCodeKokIN,
      'ko-KR' => appLocalizations.languageCodeKoKR,
      'ks-IN' => appLocalizations.languageCodeKsIN,
      'lt-LT' => appLocalizations.languageCodeLtLT,
      'lv-LV' => appLocalizations.languageCodeLvLV,
      'mai-IN' => appLocalizations.languageCodeMaiIN,
      'ml-IN' => appLocalizations.languageCodeMlIN,
      'mni-IN' => appLocalizations.languageCodeMniIN,
      'mr-IN' => appLocalizations.languageCodeMrIN,
      'ms-MY' => appLocalizations.languageCodeMsMY,
      'nb-NO' => appLocalizations.languageCodeNbNO,
      'ne-NP' => appLocalizations.languageCodeNeNP,
      'nl-BE' => appLocalizations.languageCodeNlBE,
      'nl-NL' => appLocalizations.languageCodeNlNL,
      'or-IN' => appLocalizations.languageCodeOrIN,
      'pa-IN' => appLocalizations.languageCodePaIN,
      'pl-PL' => appLocalizations.languageCodePlPL,
      'pt-BR' => appLocalizations.languageCodePtBR,
      'pt-PT' => appLocalizations.languageCodePtPT,
      'ro-RO' => appLocalizations.languageCodeRoRO,
      'ru-RU' => appLocalizations.languageCodeRuRU,
      'sa-IN' => appLocalizations.languageCodeSaIN,
      'sat-IN' => appLocalizations.languageCodeSatIN,
      'sd-IN' => appLocalizations.languageCodeSdIN,
      'si-LK' => appLocalizations.languageCodeSiLK,
      'sk-SK' => appLocalizations.languageCodeSkSK,
      'sl-SI' => appLocalizations.languageCodeSlSI,
      'sq-AL' => appLocalizations.languageCodeSqAL,
      'sr-RS' => appLocalizations.languageCodeSrRS,
      'su-ID' => appLocalizations.languageCodeSuID,
      'sv-SE' => appLocalizations.languageCodeSvSE,
      'sw-KE' => appLocalizations.languageCodeSwKE,
      'ta-IN' => appLocalizations.languageCodeTaIN,
      'te-IN' => appLocalizations.languageCodeTeIN,
      'th-TH' => appLocalizations.languageCodeThTH,
      'tr-TR' => appLocalizations.languageCodeTrTR,
      'uk-UA' => appLocalizations.languageCodeUkUA,
      'ur-IN' => appLocalizations.languageCodeUrIN,
      'ur-PK' => appLocalizations.languageCodeUrPK,
      'vi-VN' => appLocalizations.languageCodeViVN,
      'yue-HK' => appLocalizations.languageCodeYueHK,
      'zh-CN' => appLocalizations.languageCodeZhCN,
      'zh-HK' => appLocalizations.languageCodeZhHk,
      'zh-TW' => appLocalizations.languageCodeZhTW,
      _ => appLocalizations.languageCodeUnknown(locale)
    };
  }
}
