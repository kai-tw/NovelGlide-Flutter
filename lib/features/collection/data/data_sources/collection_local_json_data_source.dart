import '../../domain/entities/collection_data.dart';

abstract class CollectionLocalJsonDataSource {
  Future<CollectionData> createData([String? name]);
  Future<CollectionData> getDataById(String id);
  Future<List<CollectionData>> getList();
  Future<void> updateData(Set<CollectionData> dataSet);
  Future<void> deleteData(Set<CollectionData> dataSet);
  Future<void> reset();
}
