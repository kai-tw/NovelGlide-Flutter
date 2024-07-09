import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomepageBookDeleteDragTargetCubit extends Cubit<HomepageBookDeleteDragTargetState> {
  HomepageBookDeleteDragTargetCubit() : super(const HomepageBookDeleteDragTargetState());

  void setOnWillAccept(bool isOnWillAccept) {
    emit(state.copyWith(isOnWillAccept: isOnWillAccept));
  }
}

class HomepageBookDeleteDragTargetState extends Equatable {
  final bool isOnWillAccept;

  @override
  List<Object?> get props => [isOnWillAccept];

  const HomepageBookDeleteDragTargetState({this.isOnWillAccept = false});

  HomepageBookDeleteDragTargetState copyWith({bool? isOnWillAccept}) {
    return HomepageBookDeleteDragTargetState(
      isOnWillAccept: isOnWillAccept ?? this.isOnWillAccept,
    );
  }
}