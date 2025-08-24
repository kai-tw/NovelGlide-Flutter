import 'package:equatable/equatable.dart';

import '../../../../../enum/loading_state_code.dart';
import '../../../domain/entities/catalog_feed.dart';

class DiscoverBrowserState extends Equatable {
  const DiscoverBrowserState({
    this.code = LoadingStateCode.initial,
    this.catalogFeed,
    this.currentUri,
    this.historyStack = const <Uri>[],
    this.restoreStack = const <Uri>[],
  });

  final LoadingStateCode code;
  final CatalogFeed? catalogFeed;
  final Uri? currentUri;
  final List<Uri> historyStack;
  final List<Uri> restoreStack;

  @override
  List<Object?> get props => <Object?>[
        code,
        catalogFeed,
        currentUri,
        historyStack,
        restoreStack,
      ];

  DiscoverBrowserState copyWith({
    LoadingStateCode? code,
    CatalogFeed? catalogFeed,
    Uri? currentUri,
    List<Uri>? historyStack,
    List<Uri>? restoreStack,
  }) {
    return DiscoverBrowserState(
      code: code ?? this.code,
      catalogFeed: catalogFeed ?? this.catalogFeed,
      currentUri: currentUri ?? this.currentUri,
      historyStack: historyStack ?? this.historyStack,
      restoreStack: restoreStack ?? this.restoreStack,
    );
  }
}
