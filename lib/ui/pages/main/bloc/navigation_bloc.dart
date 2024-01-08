import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum NavigationItem { library, bookmark, settings }

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(const NavigationState(NavigationItem.library, 0, true));

  void setItem(NavigationItem item) {
    switch (item) {
      case NavigationItem.library:
        emit(const NavigationState(NavigationItem.library, 0, true));
        break;
      case NavigationItem.bookmark:
        emit(const NavigationState(NavigationItem.bookmark, 1, false));
        break;
      case NavigationItem.settings:
        emit(const NavigationState(NavigationItem.settings, 2, false));
        break;
    }
  }
}

class NavigationState extends Equatable {
  final NavigationItem navItem;
  final bool showFab;
  final int index;

  const NavigationState(this.navItem, this.index, this.showFab);

  @override
  List<Object> get props => [navItem, index, showFab];
}
