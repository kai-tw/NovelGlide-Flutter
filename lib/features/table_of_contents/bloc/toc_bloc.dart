import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum TableOfContentStateCode { unload, loading, normal, empty }

class TableOfContentCubit extends Cubit<TableOfContentState> {
  TableOfContentCubit() : super(const TableOfContentState());
}

class TableOfContentState extends Equatable {
  final TableOfContentStateCode code;

  const TableOfContentState({
    this.code = TableOfContentStateCode.unload,
  });

  @override
  List<Object?> get props => [];
}
