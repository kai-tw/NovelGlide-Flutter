part of '../tts_settings.dart';

class _Slider extends StatelessWidget {
  final String title;
  final BlocBuilderCondition<TtsSettingsState> buildWhen;
  final Function(double, bool) onChanged;
  final double min;
  final double max;
  final int divisions;
  final double Function(TtsSettingsState) valueSelector;

  const _Slider({
    required this.title,
    required this.buildWhen,
    required this.onChanged,
    required this.min,
    required this.max,
    required this.divisions,
    required this.valueSelector,
  });

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final cubit = BlocProvider.of<TtsSettingsCubit>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          Text(
            appLocalizations.ttsSettingsPitch,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          BlocBuilder<TtsSettingsCubit, TtsSettingsState>(
            buildWhen: buildWhen,
            builder: (context, state) {
              return Slider(
                value: valueSelector(state),
                onChanged: state.ttsState == TtsServiceState.stopped
                    ? (value) => onChanged(value, false)
                    : null,
                onChangeEnd: (value) => onChanged(value, true),
                min: min,
                max: max,
                divisions: divisions,
              );
            },
          ),
        ],
      ),
    );
  }
}
