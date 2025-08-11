import 'package:equatable/equatable.dart';

import '../../../../../enum/loading_state_code.dart';
import '../../../domain/entities/collection_data.dart';

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
    Set<String>? bookRelativePathSet,
  }) {
    return CollectionAddBookState(
      code: code ?? this.code,
      collectionList: collectionList ?? this.collectionList,
      selectedCollections: selectedCollections ?? this.selectedCollections,
      bookRelativePathSet: bookRelativePathSet ?? this.bookRelativePathSet,
    );
  }
}
