import 'package:equatable/equatable.dart';

import '../../../../../enum/loading_state_code.dart';
import '../../../domain/entities/catalog_feed.dart';

class DiscoverBrowserState extends Equatable {
  const DiscoverBrowserState({
    this.code = LoadingStateCode.initial,
    this.catalogFeed,
  });

  final LoadingStateCode code;
  final CatalogFeed? catalogFeed;

  @override
  List<Object?> get props => <Object?>[
        code,
        catalogFeed,
      ];
}
