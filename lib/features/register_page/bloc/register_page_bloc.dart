import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPageCubit extends Cubit<RegisterPageState> {
  RegisterPageCubit() : super(const RegisterPageState());

}

class RegisterPageState extends Equatable {
  @override
  List<Object?> get props => [];

  const RegisterPageState();
}