import 'package:equatable/equatable.dart';

import '../../../../../enum/loading_state_code.dart';
import '../../../domain/entities/catalog_feed.dart';

class DiscoverCatalogViewerState extends Equatable {
  const DiscoverCatalogViewerState({
    this.code = LoadingStateCode.initial,
    this.feed,
  });

  final LoadingStateCode code;
  final CatalogFeed? feed;

  @override
  List<Object?> get props => <Object?>[
        code,
        feed,
      ];
}
