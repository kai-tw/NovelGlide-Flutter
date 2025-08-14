import '../../main.dart';
import '../preference/domain/repositories/preference_repository.dart';
import 'data/repositories/tts_engine_impl.dart';
import 'data/repositories/tts_preference_repository_impl.dart';
import 'domain/repositories/tts_engine.dart';
import 'domain/repositories/tts_preference_repository.dart';
import 'domain/use_cases/tts_get_preference_use_case.dart';
import 'domain/use_cases/tts_get_voice_list_use_case.dart';
import 'domain/use_cases/tts_observe_state_changed_use_case.dart';
import 'domain/use_cases/tts_pause_use_case.dart';
import 'domain/use_cases/tts_reload_preference_use_case.dart';
import 'domain/use_cases/tts_reset_use_case.dart';
import 'domain/use_cases/tts_resume_use_case.dart';
import 'domain/use_cases/tts_set_pitch_use_case.dart';
import 'domain/use_cases/tts_set_speech_rate_use_case.dart';
import 'domain/use_cases/tts_set_voice_data_use_case.dart';
import 'domain/use_cases/tts_set_volume_use_case.dart';
import 'domain/use_cases/tts_speak_use_case.dart';
import 'domain/use_cases/tts_stop_use_case.dart';
import 'presentation/tts_settings_page/cubit/tts_settings_cubit.dart';

void setupTtsDependencies() {
  // Register repositories
  sl.registerLazySingleton<TtsPreferenceRepository>(
    () => TtsPreferenceRepositoryImpl(sl<PreferenceRepository>()),
  );
  sl.registerLazySingleton<TtsEngine>(
    () => TtsEngineImpl(sl<TtsPreferenceRepository>()),
  );

  // Register use cases
  sl.registerFactory<TtsGetPreferenceUseCase>(
    () => TtsGetPreferenceUseCase(sl<TtsPreferenceRepository>()),
  );
  sl.registerFactory<TtsGetVoiceListUseCase>(
    () => TtsGetVoiceListUseCase(sl<TtsEngine>()),
  );
  sl.registerFactory<TtsObserveStateChangedUseCase>(
    () => TtsObserveStateChangedUseCase(sl<TtsEngine>()),
  );
  sl.registerFactory<TtsPauseUseCase>(
    () => TtsPauseUseCase(sl<TtsEngine>()),
  );
  sl.registerFactory<TtsReloadPreferenceUseCase>(
    () => TtsReloadPreferenceUseCase(sl<TtsEngine>()),
  );
  sl.registerFactory<TtsResetUseCase>(
    () => TtsResetUseCase(sl<TtsEngine>()),
  );
  sl.registerFactory<TtsResumeUseCase>(
    () => TtsResumeUseCase(sl<TtsEngine>()),
  );
  sl.registerFactory<TtsSetPitchUseCase>(
    () => TtsSetPitchUseCase(sl<TtsEngine>()),
  );
  sl.registerFactory<TtsSetSpeechRateUseCase>(
    () => TtsSetSpeechRateUseCase(sl<TtsEngine>()),
  );
  sl.registerFactory<TtsSetVoiceDataUseCase>(
    () => TtsSetVoiceDataUseCase(sl<TtsEngine>()),
  );
  sl.registerFactory<TtsSetVolumeUseCase>(
    () => TtsSetVolumeUseCase(sl<TtsEngine>()),
  );
  sl.registerFactory<TtsSpeakUseCase>(
    () => TtsSpeakUseCase(sl<TtsEngine>()),
  );
  sl.registerFactory<TtsStopUseCase>(
    () => TtsStopUseCase(sl<TtsEngine>()),
  );

  // Register cubits
  sl.registerFactory<TtsSettingsCubit>(
    () => TtsSettingsCubit(
      sl<TtsObserveStateChangedUseCase>(),
      sl<TtsGetVoiceListUseCase>(),
      sl<TtsSpeakUseCase>(),
      sl<TtsResumeUseCase>(),
      sl<TtsStopUseCase>(),
      sl<TtsPauseUseCase>(),
      sl<TtsResetUseCase>(),
      sl<TtsSetPitchUseCase>(),
      sl<TtsSetVolumeUseCase>(),
      sl<TtsSetSpeechRateUseCase>(),
      sl<TtsSetVoiceDataUseCase>(),
      sl<TtsGetPreferenceUseCase>(),
      sl<TtsReloadPreferenceUseCase>(),
    ),
  );
}
