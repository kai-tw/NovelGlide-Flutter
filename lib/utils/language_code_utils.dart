import 'package:flutter/material.dart';

import '../generated/i18n/app_localizations.dart';

class LanguageCodeUtils {
  static String getName(BuildContext context, String code) {
    final appLocalizations = AppLocalizations.of(context)!;
    switch (code) {
      case 'mai-IN':
        return appLocalizations.languageCodeMaiIN;
      case 'hr-HR':
        return appLocalizations.languageCodeHrHR;
      case 'ko-KR':
        return appLocalizations.languageCodeKoKR;
      case 'mr-IN':
        return appLocalizations.languageCodeMrIN;
      case 'as-IN':
        return appLocalizations.languageCodeAsIN;
      case 'ru-RU':
        return appLocalizations.languageCodeRuRU;
      case 'zh-TW':
        return appLocalizations.languageCodeZhTW;
      case 'hu-HU':
        return appLocalizations.languageCodeHuHU;
      case 'sw-KE':
        return appLocalizations.languageCodeSwKE;
      case 'sd-IN':
        return appLocalizations.languageCodeSdIN;
      case 'ks-IN':
        return appLocalizations.languageCodeKsIN;
      case 'th-TH':
        return appLocalizations.languageCodeThTH;
      case 'doi-IN':
        return appLocalizations.languageCodeDoiIN;
      case 'ur-PK':
        return appLocalizations.languageCodeUrPK;
      case 'nb-NO':
        return appLocalizations.languageCodeNbNO;
      case 'da-DK':
        return appLocalizations.languageCodeDaDK;
      case 'tr-TR':
        return appLocalizations.languageCodeTrTR;
      case 'et-EE':
        return appLocalizations.languageCodeEtEE;
      case 'pt-PT':
        return appLocalizations.languageCodePtPT;
      case 'vi-VN':
        return appLocalizations.languageCodeViVN;
      case 'en-US':
        return appLocalizations.languageCodeEnUS;
      case 'ur-IN':
        return appLocalizations.languageCodeUrIN;
      case 'sat-IN':
        return appLocalizations.languageCodeSatIN;
      case 'sq-AL':
        return appLocalizations.languageCodeSqAL;
      case 'sv-SE':
        return appLocalizations.languageCodeSvSE;
      case 'ar':
        return appLocalizations.languageCodeAr;
      case 'sr-RS':
        return appLocalizations.languageCodeSrRS;
      case 'su-ID':
        return appLocalizations.languageCodeSuID;
      case 'bn-BD':
        return appLocalizations.languageCodeBnBD;
      case 'bs-BA':
        return appLocalizations.languageCodeBsBA;
      case 'mni-IN':
        return appLocalizations.languageCodeMniIN;
      case 'gu-IN':
        return appLocalizations.languageCodeGuIN;
      case 'kn-IN':
        return appLocalizations.languageCodeKnIN;
      case 'el-GR':
        return appLocalizations.languageCodeElGR;
      case 'hi-IN':
        return appLocalizations.languageCodeHiIN;
      case 'fi-FI':
        return appLocalizations.languageCodeFiFI;
      case 'bn-IN':
        return appLocalizations.languageCodeBnIN;
      case 'km-KH':
        return appLocalizations.languageCodeKmKH;
      case 'fr-FR':
        return appLocalizations.languageCodeFrFR;
      case 'uk-UA':
        return appLocalizations.languageCodeUkUA;
      case 'id-ID':
        return appLocalizations.languageCodeIdID;
      case 'pa-IN':
        return appLocalizations.languageCodePaIN;
      case 'en-AU':
        return appLocalizations.languageCodeEnAU;
      case 'nl-NL':
        return appLocalizations.languageCodeNlNL;
      case 'fr-CA':
        return appLocalizations.languageCodeFrCA;
      case 'lv-LV':
        return appLocalizations.languageCodeLvLV;
      case 'he-IL':
        return appLocalizations.languageCodeHeIL;
      case 'pt-BR':
        return appLocalizations.languageCodePtBR;
      case 'de-DE':
        return appLocalizations.languageCodeDeDE;
      case 'ml-IN':
        return appLocalizations.languageCodeMlIN;
      case 'si-LK':
        return appLocalizations.languageCodeSiLK;
      case 'cs-CZ':
        return appLocalizations.languageCodeCsCZ;
      case 'is-IS':
        return appLocalizations.languageCodeIsIS;
      case 'pl-PL':
        return appLocalizations.languageCodePlPL;
      case 'ca-ES':
        return appLocalizations.languageCodeCaES;
      case 'sk-SK':
        return appLocalizations.languageCodeSkSK;
      case 'it-IT':
        return appLocalizations.languageCodeItIT;
      case 'fil-PH':
        return appLocalizations.languageCodeFilPH;
      case 'lt-LT':
        return appLocalizations.languageCodeLtLT;
      case 'ne-NP':
        return appLocalizations.languageCodeNeNP;
      case 'ms-MY':
        return appLocalizations.languageCodeMsMY;
      case 'en-NG':
        return appLocalizations.languageCodeEnNG;
      case 'nl-BE':
        return appLocalizations.languageCodeNlBE;
      case 'zh-CN':
        return appLocalizations.languageCodeZhCN;
      case 'es-ES':
        return appLocalizations.languageCodeEsES;
      case 'ja-JP':
        return appLocalizations.languageCodeJaJP;
      case 'ta-IN':
        return appLocalizations.languageCodeTaIN;
      case 'bg-BG':
        return appLocalizations.languageCodeBgBG;
      case 'cy-GB':
        return appLocalizations.languageCodeCyGB;
      case 'or-IN':
        return appLocalizations.languageCodeOrIN;
      case 'brx-IN':
        return appLocalizations.languageCodeBrxIN;
      case 'sa-IN':
        return appLocalizations.languageCodeSaIN;
      case 'yue-HK':
        return appLocalizations.languageCodeYueHK;
      case 'es-US':
        return appLocalizations.languageCodeEsUS;
      case 'en-IN':
        return appLocalizations.languageCodeEnIN;
      case 'kok-IN':
        return appLocalizations.languageCodeKokIN;
      case 'jv-ID':
        return appLocalizations.languageCodeJvID;
      case 'sl-SI':
        return appLocalizations.languageCodeSlSI;
      case 'te-IN':
        return appLocalizations.languageCodeTeIN;
      case 'ro-RO':
        return appLocalizations.languageCodeRoRO;
      case 'en-GB':
        return appLocalizations.languageCodeEnGB;
      default:
        return appLocalizations.languageCodeUnknown(code);
    }
  }
}
