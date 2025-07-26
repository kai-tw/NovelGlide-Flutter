part of '../collection_add_book_scaffold.dart';

class CollectionAddBookState extends Equatable {
  const CollectionAddBookState({
    this.code = LoadingStateCode.initial,
    this.collectionList = const <CollectionData>[],
    this.selectedCollections = const <String>{},
    this.bookPathSet = const <String>{},
  });

  final LoadingStateCode code;
  final List<CollectionData> collectionList;
  final Set<String> selectedCollections;
  final Set<String> bookPathSet;

  @override
  List<Object?> get props => <Object?>[
        code,
        collectionList,
        selectedCollections,
        bookPathSet,
      ];

  CollectionAddBookState copyWith({
    LoadingStateCode? code,
    List<CollectionData>? collectionList,
    Set<String>? selectedCollections,
    Set<String>? bookPathSet,
  }) {
    return CollectionAddBookState(
      code: code ?? this.code,
      collectionList: collectionList ?? this.collectionList,
      selectedCollections: selectedCollections ?? this.selectedCollections,
      bookPathSet: bookPathSet ?? this.bookPathSet,
    );
  }
}
