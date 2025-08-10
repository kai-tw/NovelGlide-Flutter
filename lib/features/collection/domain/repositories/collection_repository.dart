import 'dart:async';

import '../entities/collection_data.dart';

abstract class CollectionRepository {
  StreamController<void> get onChangedController;

  Future<CollectionData> createData([String? name]);

  Future<CollectionData> getDataById(String id);

  Future<List<CollectionData>> getList();

  Future<void> updateData(Set<CollectionData> dataSet);

  Future<void> deleteData(Set<CollectionData> dataSet);

  Future<void> reset();
}
