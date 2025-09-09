import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/use_cases/collection_create_data_use_case.dart';
import 'collection_add_state.dart';

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
