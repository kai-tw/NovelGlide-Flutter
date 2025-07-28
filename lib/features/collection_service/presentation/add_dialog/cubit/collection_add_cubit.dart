part of '../../../collection_service.dart';

class CollectionAddCubit extends Cubit<CollectionAddState> {
  CollectionAddCubit() : super(const CollectionAddState());

  set name(String name) => emit(CollectionAddState(name: name));

  Future<void> submit() async {
    if (state.isValid) {
      // Tell the repository to create a new collection
      await CollectionService.repository.create(state.name);
    }
  }
}
