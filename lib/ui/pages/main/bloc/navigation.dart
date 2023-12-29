import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum NavigationItem { library, bookmark, settings }

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(const NavigationState(NavigationItem.library, 0));

  void setItem(NavigationItem item) {
    switch (item) {
      case NavigationItem.library:
        emit(NavigationState(item, 0));
        break;
      case NavigationItem.bookmark:
        emit(NavigationState(item, 1));
        break;
      case NavigationItem.settings:
        emit(NavigationState(item, 2));
        break;
    }
  }
}

class NavigationState extends Equatable {
  final NavigationItem navItem;
  final int index;

  const NavigationState(this.navItem, this.index);

  @override
  List<Object> get props => [navItem, index];
}
