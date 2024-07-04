import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReaderProgressBarCubit extends Cubit<ReaderProgressBarState> {
  int sampleCount = 0;

  ReaderProgressBarCubit() : super(const ReaderProgressBarState());

  void update(double currentScrollY, double maxScrollY) {
    // Because the CustomScrollView builds items in the viewport,
    // the maxScrollExtent is not a fixed value.
    // Therefore, to reduce the error of the value,
    // the maxScrollY is calculated by averaging the previous value and the current value.
    final double stateRatio = sampleCount / (sampleCount + 1);
    final double newRatio = 1 / (sampleCount + 1);
    sampleCount++;

    final double avgMaxScrollY = stateRatio * state.maxScrollY + newRatio * maxScrollY;
    emit(ReaderProgressBarState(currentScrollY: currentScrollY, maxScrollY: avgMaxScrollY));
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