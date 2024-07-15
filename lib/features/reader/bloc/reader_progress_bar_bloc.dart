import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReaderProgressBarCubit extends Cubit<ReaderProgressBarState> {
  ReaderProgressBarCubit() : super(const ReaderProgressBarState());

  void setState(double currentScrollY, double maxScrollY) {
    emit(ReaderProgressBarState(
      currentScrollY: currentScrollY.clamp(0.0, maxScrollY),
      maxScrollY: maxScrollY,
    ));
  }

  void reset() {
    emit(const ReaderProgressBarState());
  }
}

class ReaderProgressBarState extends Equatable {
  final double currentScrollY;
  final double maxScrollY;

  @override
  List<Object?> get props => [
        currentScrollY,
        maxScrollY,
      ];

  const ReaderProgressBarState({
    this.currentScrollY = 0.0,
    this.maxScrollY = 1.0,
  });
}
