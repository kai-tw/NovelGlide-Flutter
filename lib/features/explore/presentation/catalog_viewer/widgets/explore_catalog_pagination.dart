import 'package:flutter/material.dart';

import '../../../domain/entities/publication_link.dart';
import 'buttons/explore_catalog_pagination_next_button.dart';

class ExploreCatalogPagination extends StatelessWidget {
  const ExploreCatalogPagination({
    super.key,
    this.nextLink,
    this.onVisit,
  });

  final PublicationLink? nextLink;
  final Future<void> Function(Uri uri)? onVisit;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.only(bottom: 24.0),
      sliver: SliverToBoxAdapter(
        child: Center(
          child: OverflowBar(
            children: <Widget?>[
              nextLink == null
                  ? null
                  : ExploreCatalogPaginationNextButton(
                      nextLink: nextLink,
                      onVisit: onVisit,
                    ),
            ].whereType<Widget>().toList(),
          ),
        ),
      ),
    );
  }
}
