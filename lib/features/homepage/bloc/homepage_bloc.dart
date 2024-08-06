import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomepageCubit extends Cubit<HomepageState> {
  final PageStorageBucket bookshelfBucket = PageStorageBucket();
  final PageStorageBucket bookmarkBucket = PageStorageBucket();

  HomepageCubit() : super(const HomepageState());
  
  void setItem(HomepageNavigationItem item) {
    emit(state.copyWith(navItem: item));
  }
}

class HomepageState extends Equatable {
  final HomepageNavigationItem navItem;

  @override
  List<Object> get props => [navItem];

  const HomepageState({
    this.navItem = HomepageNavigationItem.bookshelf,
  });
  
  HomepageState copyWith({
    HomepageNavigationItem? navItem,
  }) {
    return HomepageState(
      navItem: navItem ?? this.navItem,
    );
  }
}

enum HomepageNavigationItem { bookshelf, bookmark, settings }
