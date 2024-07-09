import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomepageCubit extends Cubit<HomepageState> {
  HomepageCubit() : super(const HomepageState());

  void setDragging(bool isDragging) {
    emit(HomepageState(isDragging: isDragging));
  }
}

class HomepageState extends Equatable {
  final bool isDragging;

  @override
  List<Object> get props => [isDragging];

  const HomepageState({
    this.isDragging = false,
  });
}