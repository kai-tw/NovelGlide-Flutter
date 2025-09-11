part of 'homepage_cubit.dart';

enum HomepageNavigationItem {
  bookshelf,
  explore,
  bookmark,
  settings;

  /// Get the value of the enum from the index. (Within save range)
  factory HomepageNavigationItem.fromIndex(int index) {
    return values[index.clamp(0, values.length - 1)];
  }

  bool get isBookshelf => this == HomepageNavigationItem.bookshelf;

  bool get isDiscovery => this == HomepageNavigationItem.explore;

  bool get isBookmark => this == HomepageNavigationItem.bookmark;

  bool get isSettings => this == HomepageNavigationItem.settings;
}
