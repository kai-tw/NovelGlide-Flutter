part of '../../../collection_service.dart';

class CollectionAddCubit extends Cubit<CollectionAddState> {
  CollectionAddCubit(
    this._createCollectionDataUseCase,
  ) : super(const CollectionAddState());

  final CollectionCreateDataUseCase _createCollectionDataUseCase;

  set name(String name) => emit(CollectionAddState(name: name));

  Future<void> submit() async {
    if (state.isValid) {
      // Tell the repository to create a new collection
      await _createCollectionDataUseCase(state.name);
    }
  }
}
