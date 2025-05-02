part of 'homepage_cubit.dart';

enum HomepageNavigationItem {
  bookshelf,
  collection,
  bookmark,
  settings;

  bool get isBookshelf => this == HomepageNavigationItem.bookshelf;

  bool get isCollection => this == HomepageNavigationItem.collection;

  bool get isBookmark => this == HomepageNavigationItem.bookmark;

  bool get isSettings => this == HomepageNavigationItem.settings;
}
