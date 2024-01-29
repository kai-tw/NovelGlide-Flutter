import 'package:equatable/equatable.dart';

/// To shorten the class name, use the abbreviation.
/// Reference: https://www.abbreviations.com/

/// The state of buttons in the reader & its setting page.
class RdrBtnState extends Equatable {
  final RdrBtnAddBkmState addBkmState;
  final RdrBtnJmpToBkmState jmpToBkmState;
  final RdrBtnRstSettingsState rstSettingsState;

  const RdrBtnState({
    this.addBkmState = RdrBtnAddBkmState.normal,
    this.jmpToBkmState = RdrBtnJmpToBkmState.normal,
    this.rstSettingsState = RdrBtnRstSettingsState.normal,
  });

  RdrBtnState copyWith({
    RdrBtnAddBkmState? addBkmState,
    RdrBtnJmpToBkmState? jmpToBkmState,
    RdrBtnRstSettingsState? rstSettingsState,
  }) {
    return RdrBtnState(
      addBkmState: addBkmState ?? this.addBkmState,
      jmpToBkmState: jmpToBkmState ?? this.jmpToBkmState,
      rstSettingsState: rstSettingsState ?? this.rstSettingsState,
    );
  }

  @override
  List<Object?> get props => [
        addBkmState,
        jmpToBkmState,
        rstSettingsState,
      ];
}

/// The state of the button that add a bookmark.
enum RdrBtnAddBkmState { normal, disabled, clicked }

/// The state of the button that jump to the bookmark.
enum RdrBtnJmpToBkmState { normal, disabled }

/// The state of the button that reset the settings.
enum RdrBtnRstSettingsState { normal, disabled, clicked }
