part of '../homepage.dart';

class HomepageCubit extends Cubit<_HomepageState> {
  HomepageCubit() : super(const _HomepageState());
  final PageStorageBucket bookshelfBucket = PageStorageBucket();
  final PageStorageBucket collectionBucket = PageStorageBucket();
  final PageStorageBucket bookmarkBucket = PageStorageBucket();

  void setItem(HomepageNavigationItem item) {
    emit(state.copyWith(navItem: item));
  }
}

class _HomepageState extends Equatable {
  const _HomepageState({this.navItem = HomepageNavigationItem.bookshelf});

  final HomepageNavigationItem navItem;

  @override
  List<Object> get props => <Object>[navItem];

  _HomepageState copyWith({
    HomepageNavigationItem? navItem,
  }) {
    return _HomepageState(
      navItem: navItem ?? this.navItem,
    );
  }
}

enum HomepageNavigationItem { bookshelf, collection, bookmark, settings }
