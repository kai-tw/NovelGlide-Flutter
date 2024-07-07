import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum NavigationItem { bookshelf, bookmark, settings }

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(const NavigationState());

  void setItem(NavigationItem item) {
    switch (item) {
      case NavigationItem.bookshelf:
        emit(const NavigationState(navItem: NavigationItem.bookshelf));
        break;
      case NavigationItem.bookmark:
        emit(const NavigationState(navItem: NavigationItem.bookmark));
        break;
      case NavigationItem.settings:
        emit(const NavigationState(navItem: NavigationItem.settings));
        break;
    }
  }
}

class NavigationState extends Equatable {
  final NavigationItem navItem;

  const NavigationState({
    this.navItem = NavigationItem.bookshelf,
  });

  @override
  List<Object> get props => [navItem];
}
