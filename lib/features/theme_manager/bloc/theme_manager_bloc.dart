part of '../theme_manager.dart';

class ThemeManagerCubit extends Cubit<ThemeManagerState> {
  final ScrollController scrollController = ScrollController();

  factory ThemeManagerCubit() {
    final cubit = ThemeManagerCubit._internal(const ThemeManagerState());
    cubit._initialize();
    return cubit;
  }

  ThemeManagerCubit._internal(super.initialState);

  Future<void> _initialize() async {
    final record = await ThemeDataRecord.fromSettings();
    emit(ThemeManagerState(brightness: record.brightness));
  }

  /// Set the brightness of the theme.
  void setBrightness(Brightness? brightness) {
    emit(ThemeManagerState(brightness: brightness));
  }

  @override
  Future<void> close() async {
    super.close();
    scrollController.dispose();
  }
}

class ThemeManagerState extends Equatable {
  final Brightness? brightness;

  @override
  List<Object?> get props => [brightness];

  const ThemeManagerState({this.brightness});
}
