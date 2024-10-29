import '../utils/file_path.dart';
import '../utils/file_utils.dart';
import 'collection_repository.dart';

/// Represents a collection of data with an ID, name, and a list of paths.
class CollectionData {
  final String id;
  final String name;
  List<String> pathList;

  CollectionData(this.id, this.name, this.pathList);

  /// Retrieves a [CollectionData] instance by its ID.
  factory CollectionData.fromId(String id) {
    if (CollectionRepository.jsonData.containsKey(id)) {
      return CollectionData.fromJson(CollectionRepository.jsonData[id]!);
    } else {
      return CollectionData(id, id, const <String>[]);
    }
  }

  /// Creates a [CollectionData] instance from a JSON map.
  factory CollectionData.fromJson(Map<String, dynamic> json) {
    return CollectionData(
      json['id'] as String,
      json['name'] as String,
      List<String>.from(json['pathList'] ?? [])
          .map<String>(
              (e) => FileUtils.getAbsolutePath(e, FilePath.libraryRoot))
          .toList(),
    );
  }

  /// Converts the [CollectionData] instance to a JSON map.
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'pathList': pathList
            .map<String>(
                (e) => FileUtils.getRelativePath(e, FilePath.libraryRoot))
            .toList(),
      };
}
