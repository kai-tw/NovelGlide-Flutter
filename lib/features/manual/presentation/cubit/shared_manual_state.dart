import 'package:equatable/equatable.dart';

import '../../../../enum/loading_state_code.dart';

class SharedManualState extends Equatable {
  const SharedManualState({
    this.code = LoadingStateCode.initial,
    this.markdown,
  });

  final LoadingStateCode code;
  final String? markdown;

  @override
  List<Object?> get props => <Object?>[
        code,
        markdown,
      ];

  SharedManualState copyWith({
    LoadingStateCode? code,
    String? markdown,
  }) {
    return SharedManualState(
      code: code ?? this.code,
      markdown: markdown ?? this.markdown,
    );
  }
}
