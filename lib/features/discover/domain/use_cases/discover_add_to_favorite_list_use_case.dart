import 'dart:math';

import '../../../../core/domain/use_cases/use_case.dart';
import '../../../../core/utils/random_extension.dart';
import '../entities/discover_favorite_catalog_data.dart';
import '../repositories/discover_favorite_repository.dart';

class DiscoverAddToFavoriteListUseCaseParam {
  const DiscoverAddToFavoriteListUseCaseParam({
    required this.name,
    required this.uri,
  });

  final String name;
  final Uri uri;
}

/// Add a favorite server to the list
class DiscoverAddToFavoriteListUseCase
    extends UseCase<Future<void>, DiscoverAddToFavoriteListUseCaseParam> {
  DiscoverAddToFavoriteListUseCase(this._repository);

  final DiscoverFavoriteRepository _repository;

  @override
  Future<void> call(DiscoverAddToFavoriteListUseCaseParam parameter) async {
    final Random random = Random();
    String identifier = random.nextString(10);

    // Check if the identifier already exists.
    while (await _repository.existsData(identifier)) {
      identifier = random.nextString(10);
    }

    // Create data
    _repository.createData(DiscoverFavoriteCatalogData(
      identifier: identifier,
      name: parameter.name,
      uri: parameter.uri,
    ));

    // Get the list.
    final List<String> identifierList = await _repository.getList();

    if (!identifierList.contains(identifier)) {
      // Doesn't exist in the list. Add to the list.
      identifierList.add(identifier);

      // Save the list.
      await _repository.saveList(identifierList);
    }
  }
}
