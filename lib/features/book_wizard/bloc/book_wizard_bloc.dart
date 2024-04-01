import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookWizardCubit extends Cubit<BookWizardState> {
  BookWizardCubit() : super(const BookWizardState());

}

class BookWizardState extends Equatable {


  @override
  List<Object?> get props => [];

  const BookWizardState();
}