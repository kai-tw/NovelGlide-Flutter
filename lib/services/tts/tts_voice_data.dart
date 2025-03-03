part of 'tts_service.dart';

class TtsVoiceData {
  String name;
  String locale;

  TtsVoiceData({
    required this.name,
    required this.locale,
  });

  factory TtsVoiceData.fromJson(String json) {
    final map = jsonDecode(json) as Map<String, dynamic>;
    return TtsVoiceData(
      name: map['name'] as String,
      locale: map['locale'] as String,
    );
  }

  String toJson() {
    return jsonEncode(toMap());
  }

  Map<String, String> toMap() {
    return {
      'name': name,
      'locale': locale,
    };
  }

  @override
  String toString() {
    return 'TtsVoiceData(name: $name, locale: $locale)';
  }
}
