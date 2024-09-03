import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CollectionAddCubit extends Cubit<CollectionAddState> {
  set name(String? name) => emit(CollectionAddState(name: name));

  CollectionAddCubit() : super(const CollectionAddState());
}

class CollectionAddState extends Equatable {
  final String? name;

  @override
  List<Object?> get props => [name];

  const CollectionAddState({this.name});
}