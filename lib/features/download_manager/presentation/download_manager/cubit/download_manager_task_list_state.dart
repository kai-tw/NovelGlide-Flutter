import 'package:equatable/equatable.dart';

import '../../../../../enum/loading_state_code.dart';

class DownloadManagerTaskListState extends Equatable {
  const DownloadManagerTaskListState({
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
