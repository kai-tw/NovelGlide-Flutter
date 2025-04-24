part of '../tts_settings.dart';

class _Slider extends StatelessWidget {
  const _Slider({
    required this.title,
    required this.buildWhen,
    required this.onChanged,
    required this.min,
    required this.max,
    required this.divisions,
    required this.valueSelector,
  });

  final String title;
  final BlocBuilderCondition<TtsSettingsState> buildWhen;
  final Function(double, bool) onChanged;
  final double min;
  final double max;
  final int divisions;
  final double Function(TtsSettingsState) valueSelector;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: <Widget>[
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          BlocBuilder<TtsSettingsCubit, TtsSettingsState>(
            buildWhen: buildWhen,
            builder: (BuildContext context, TtsSettingsState state) {
              return Slider(
                value: valueSelector(state),
                onChanged: state.ttsState == TtsServiceState.stopped
                    ? (double value) => onChanged(value, false)
                    : null,
                onChangeEnd: (double value) => onChanged(value, true),
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
