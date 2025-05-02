part of 'homepage_cubit.dart';

class HomepageState extends Equatable {
  const HomepageState({
    this.navItem = HomepageNavigationItem.bookshelf,
    this.isEnabled = true,
  });

  final HomepageNavigationItem navItem;
  final bool isEnabled;

  @override
  List<Object> get props => <Object>[navItem, isEnabled];

  HomepageState copyWith({
    HomepageNavigationItem? navItem,
    bool? isEnabled,
  }) {
    return HomepageState(
      navItem: navItem ?? this.navItem,
      isEnabled: isEnabled ?? this.isEnabled,
    );
  }
}
