import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum NavigationItem { bookshelf, bookmark, settings }

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(const NavigationState());

  void setItem(NavigationItem item) {
    emit(NavigationState(navItem: item));
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
