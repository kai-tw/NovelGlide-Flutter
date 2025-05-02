part of 'homepage_cubit.dart';

class HomepageState extends Equatable {
  const HomepageState({this.navItem = HomepageNavigationItem.bookshelf});

  final HomepageNavigationItem navItem;

  @override
  List<Object> get props => <Object>[navItem];

  HomepageState copyWith({
    HomepageNavigationItem? navItem,
  }) {
    return HomepageState(
      navItem: navItem ?? this.navItem,
    );
  }
}
