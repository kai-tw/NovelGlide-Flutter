import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReaderCubit extends Cubit<ReaderState> {
  ReaderCubit() : super(const ReaderState());
}

class ReaderState extends Equatable {

  const ReaderState();

  @override
  List<Object?> get props => [];
}
