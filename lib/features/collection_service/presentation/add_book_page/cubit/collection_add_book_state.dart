part of '../../../collection_service.dart';

class CollectionAddBookState extends Equatable {
  const CollectionAddBookState({
    this.code = LoadingStateCode.initial,
    this.collectionList = const <CollectionData>[],
    this.selectedCollections = const <CollectionData>{},
    this.bookRelativePathSet = const <String>{},
  });

  final LoadingStateCode code;
  final List<CollectionData> collectionList;
  final Set<CollectionData> selectedCollections;
  final Set<String> bookRelativePathSet;

  @override
  List<Object?> get props => <Object?>[
        code,
        collectionList,
        selectedCollections,
        bookRelativePathSet,
      ];

  CollectionAddBookState copyWith({
    LoadingStateCode? code,
    List<CollectionData>? collectionList,
    Set<CollectionData>? selectedCollections,
    Set<String>? bookPathSet,
  }) {
    return CollectionAddBookState(
      code: code ?? this.code,
      collectionList: collectionList ?? this.collectionList,
      selectedCollections: selectedCollections ?? this.selectedCollections,
      bookRelativePathSet: bookPathSet ?? this.bookRelativePathSet,
    );
  }
}
