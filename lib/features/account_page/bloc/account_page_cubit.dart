import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountPageCubit extends Cubit<AccountPageState> {
  AccountPageCubit() : super(const AccountPageState());

}

class AccountPageState extends Equatable {
  @override
  List<Object?> get props => [];

  const AccountPageState();
}