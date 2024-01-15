import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum NavigationItem { bookshelf, bookmark, settings }

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(const NavigationState(showFab: true));

  void setItem(NavigationItem item) {
    switch (item) {
      case NavigationItem.bookshelf:
        emit(const NavigationState(navItem: NavigationItem.bookshelf, showFab: true));
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
  final bool showFab;

  const NavigationState({
    this.navItem = NavigationItem.bookshelf,
    this.showFab = false,
  });

  @override
  List<Object> get props => [navItem, showFab];
}
