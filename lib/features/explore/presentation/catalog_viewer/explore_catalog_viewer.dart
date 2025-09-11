import 'package:flutter/material.dart';

import '../../../locale_system/locale_utils.dart';
import '../../domain/entities/catalog_feed.dart';
import 'widgets/explore_catalog_pagination.dart';
import 'widgets/explore_entry_widget.dart';

class ExploreCatalogViewer extends StatelessWidget {
  const ExploreCatalogViewer({
    super.key,
    required this.feed,
    this.onVisit,
    this.onDownload,
  });

  final CatalogFeed feed;
  final Future<void> Function(Uri uri)? onVisit;
  final Future<void> Function(Uri uri, String? entryTitle)? onDownload;

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: CustomScrollView(
        slivers: <Widget?>[
          SliverToBoxAdapter(
            child: ListTile(
              contentPadding: const EdgeInsets.fromLTRB(
                16.0,
                24.0,
                16.0,
                0.0,
              ),
              leading: const Icon(Icons.local_library_rounded),
              title: Text(
                feed.title ?? '',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
              ),
              subtitle: Text(
                LocaleUtils.dateTimeOf(context, feed.updated) ?? '',
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return ExploreEntryWidget(
                  entry: feed.entries[index],
                  onVisit: onVisit,
                  onDownload: onDownload,
                );
              },
              childCount: feed.entries.length,
            ),
          ),
          ExploreCatalogPagination(
            nextLink: feed.nextLink,
            onVisit: onVisit,
          ),
        ].whereType<Widget>().toList(),
      ),
    );
  }
}
