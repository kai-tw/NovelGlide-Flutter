import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum AddBookNameStateCode { valid, blank, invalid, exists }

class AddBookCubit extends Cubit<AddBookState> {
  AddBookCubit() : super(const AddBookState());
}

class AddBookState extends Equatable {

  const AddBookState();

  @override
  List<Object?> get props => [];
}