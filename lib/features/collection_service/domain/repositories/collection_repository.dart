import 'dart:async';

import '../entities/collection_data.dart';

abstract class CollectionRepository {
  final StreamController<void> onChangedController =
      StreamController<void>.broadcast();

  Future<CollectionData> createData([String? name]);
  Future<CollectionData> getDataById(String id);
  Future<List<CollectionData>> getList();
  Future<void> updateData(Set<CollectionData> dataSet);
  Future<void> deleteData(Set<CollectionData> dataSet);
  Future<void> reset();
}
