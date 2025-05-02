import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'homepage_navigation_code.dart';
part 'homepage_state.dart';

class HomepageCubit extends Cubit<HomepageState> {
  HomepageCubit() : super(const HomepageState());
  final PageStorageBucket bookshelfBucket = PageStorageBucket();
  final PageStorageBucket collectionBucket = PageStorageBucket();
  final PageStorageBucket bookmarkBucket = PageStorageBucket();

  set item(HomepageNavigationItem item) {
    emit(state.copyWith(navItem: item));
  }

  set isEnabled(bool value) {
    emit(state.copyWith(isEnabled: value));
  }
}
