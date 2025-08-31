import 'package:equatable/equatable.dart';

import '../../../../../enum/loading_state_code.dart';

class DownloadManagerState extends Equatable {
  const DownloadManagerState({
    this.code = LoadingStateCode.initial,
    this.identifierList = const <String>[],
  });

  final LoadingStateCode code;
  final List<String> identifierList;

  @override
  List<Object?> get props => <Object?>[
        code,
        identifierList,
      ];
}
