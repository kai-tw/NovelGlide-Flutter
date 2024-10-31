part of '../homepage.dart';

class HomepageCubit extends Cubit<_HomepageState> {
  final PageStorageBucket bookshelfBucket = PageStorageBucket();
  final PageStorageBucket collectionBucket = PageStorageBucket();
  final PageStorageBucket bookmarkBucket = PageStorageBucket();

  HomepageCubit({
    HomepageNavigationItem initialItem = HomepageNavigationItem.bookshelf,
  }) : super(_HomepageState(navItem: initialItem));

  void setItem(HomepageNavigationItem item) {
    emit(state.copyWith(navItem: item));
  }
}

class _HomepageState extends Equatable {
  final HomepageNavigationItem navItem;

  @override
  List<Object> get props => [navItem];

  const _HomepageState({required this.navItem});

  _HomepageState copyWith({
    HomepageNavigationItem? navItem,
  }) {
    return _HomepageState(
      navItem: navItem ?? this.navItem,
    );
  }
}

enum HomepageNavigationItem { bookshelf, collection, bookmark, settings }
