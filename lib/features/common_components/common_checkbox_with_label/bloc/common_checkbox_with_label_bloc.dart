import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommonCheckboxWithLabelCubit extends Cubit<CommonCheckboxWithLabelState> {
  CommonCheckboxWithLabelCubit({bool isChecked = false}) : super(CommonCheckboxWithLabelState(isChecked: isChecked));

  void onClick(bool? value) {
    emit(CommonCheckboxWithLabelState(isChecked: value == true));
  }
}

class CommonCheckboxWithLabelState extends Equatable {
  final bool isChecked;

  const CommonCheckboxWithLabelState({required this.isChecked});

  @override
  List<Object?> get props => [isChecked];
}
