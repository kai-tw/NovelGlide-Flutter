import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeManagerCubit extends Cubit<ThemeManagerState> {
  final ScrollController scrollController = ScrollController();

  ThemeManagerCubit() : super(const ThemeManagerState());

  @override
  Future<void> close() async {
    super.close();
    scrollController.dispose();
  }
}

class ThemeManagerState extends Equatable {
  @override
  List<Object?> get props => [];

  const ThemeManagerState();
}