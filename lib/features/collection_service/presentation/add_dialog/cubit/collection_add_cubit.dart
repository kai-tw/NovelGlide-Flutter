part of '../../../collection_service.dart';

class CollectionAddCubit extends Cubit<CollectionAddState> {
  CollectionAddCubit({
    this.listCubit,
    this.addBookCubit,
  }) : super(const CollectionAddState());

  final CollectionListCubit? listCubit;
  final CollectionAddBookCubit? addBookCubit;

  set name(String name) => emit(CollectionAddState(name: name));

  Future<void> submit() async {
    if (state.isValid) {
      // Tell the repository to create a new collection
      await CollectionService.repository.create(state.name);

      // Refresh the collection list
      listCubit?.refresh();

      // Refresh the list in add book to collection page
      addBookCubit?.refresh();
    }
  }
}
