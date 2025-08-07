import 'package:novel_glide/features/collection_service/domain/entities/collection_data.dart';

import '../../domain/repositories/collection_repository.dart';
import '../data_sources/collection_local_json_data_source.dart';

class CollectionRepositoryImpl extends CollectionRepository {
  CollectionRepositoryImpl(this._collectionLocalDataSource);

  final CollectionLocalJsonDataSource _collectionLocalDataSource;

  @override
  Future<CollectionData> createData([String? name]) async {
    final CollectionData data =
        await _collectionLocalDataSource.createData(name);

    // Send a notification
    onChangedController.add(null);

    return data;
  }

  @override
  Future<void> deleteData(Set<CollectionData> dataSet) async {
    await _collectionLocalDataSource.deleteData(dataSet);

    // Send a notification
    onChangedController.add(null);
  }

  @override
  Future<CollectionData> getDataById(String id) {
    return _collectionLocalDataSource.getDataById(id);
  }

  @override
  Future<List<CollectionData>> getList() {
    return _collectionLocalDataSource.getList();
  }

  @override
  Future<void> updateData(Set<CollectionData> dataSet) async {
    await _collectionLocalDataSource.updateData(dataSet);

    // Send a notification
    onChangedController.add(null);
  }

  @override
  Future<void> reset() async {
    await _collectionLocalDataSource.reset();

    // Send a notification
    onChangedController.add(null);
  }
}
