import 'package:flutter/material.dart';

import '../../../../core/mime_resolver/domain/entities/mime_type.dart';
import '../../../books/domain/entities/book_cover.dart';
import '../../../books/presentation/book_cover/shared_book_cover_widget.dart';
import '../../../locale_system/locale_utils.dart';
import '../../domain/entities/publication_author.dart';
import '../../domain/entities/publication_entry.dart';
import '../../domain/entities/publication_link.dart';
import '../link_widget/discover_link_widget.dart';

class DiscoverEntryWidget extends StatelessWidget {
  const DiscoverEntryWidget({
    super.key,
    required this.entry,
    this.onVisit,
    this.onDowload,
  });

  final PublicationEntry entry;
  final Future<void> Function(Uri uri)? onVisit;
  final Future<void> Function(Uri uri)? onDowload;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget?>[
            Row(
              children: <Widget?>[
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget?>[
                      _buildCardIcon(context),
                      _buildTitle(context),
                      _buildAuthors(context),
                      _buildSummary(context),
                      _buildPublishedDate(context),
                      _buildPublisher(context),
                    ].whereType<Widget>().toList(),
                  ),
                ),
                _buildCover(context),
              ].whereType<Widget>().toList(),
            ),
            _buildLinkWidget(context),
          ].whereType<Widget>().toList(),
        ),
      ),
    );
  }

  Widget? _buildCardIcon(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(bottom: 16.0),
      child: Icon(Icons.feed, size: 36.0),
    );
  }

  Widget? _buildTitle(BuildContext context) {
    if (entry.title == null) {
      return null;
    } else {
      return Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Text(
          entry.title!,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
      );
    }
  }

  Widget? _buildAuthors(BuildContext context) {
    if (entry.authors.isEmpty) {
      return null;
    } else {
      return ListTile(
        contentPadding: EdgeInsets.zero,
        leading: const Icon(Icons.person),
        title: Text(
          entry.authors
              .map((PublicationAuthor author) => author.name)
              .join(', '),
        ),
        titleTextStyle: Theme.of(context).textTheme.bodyMedium,
      );
    }
  }

  Widget? _buildSummary(BuildContext context) {
    if (entry.content == null || entry.content!.isEmpty) {
      return null;
    } else {
      return Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Text(entry.content!),
      );
    }
  }

  Widget? _buildPublishedDate(BuildContext context) {
    if (entry.publishedDate == null) {
      return null;
    } else {
      return ListTile(
        contentPadding: EdgeInsets.zero,
        leading: const Icon(Icons.calendar_today_rounded),
        title: Text(LocaleUtils.dateTimeOf(context, entry.publishedDate) ?? ''),
        titleTextStyle: Theme.of(context).textTheme.bodyMedium,
        textColor: Theme.of(context).colorScheme.secondary,
        iconColor: Theme.of(context).colorScheme.secondary,
        visualDensity: VisualDensity.compact,
      );
    }
  }

  Widget? _buildPublisher(BuildContext context) {
    if (entry.publisher == null) {
      return null;
    } else {
      return ListTile(
        contentPadding: EdgeInsets.zero,
        leading: const Icon(Icons.business_rounded),
        title: Text(LocaleUtils.dateTimeOf(context, entry.publishedDate) ?? ''),
        titleTextStyle: Theme.of(context).textTheme.bodyMedium,
        textColor: Theme.of(context).colorScheme.secondary,
        iconColor: Theme.of(context).colorScheme.secondary,
        visualDensity: VisualDensity.compact,
      );
    }
  }

  Widget? _buildLinkWidget(BuildContext context) {
    final Iterable<PublicationLink> supportedLinks = entry.links.where(
        (PublicationLink link) =>
            link.type == MimeType.atomFeed || link.type == MimeType.epub);
    if (supportedLinks.isEmpty) {
      return null;
    } else {
      return OverflowBar(
        alignment: MainAxisAlignment.center,
        children: supportedLinks
            .map((PublicationLink link) => DiscoverLinkWidget(
                  link: link,
                  onVisit: onVisit,
                  onDownload: onDowload,
                ))
            .toList(),
      );
    }
  }

  Widget? _buildCover(BuildContext context) {
    final List<PublicationLink> priorityList = <PublicationLink>[];

    // Make sure the cover is prioritized over the thumbnail.
    int coverIndex = 0;
    for (final PublicationLink link in entry.links) {
      switch (link.rel) {
        case PublicationLinkRelationship.cover:
          priorityList.insert(coverIndex++, link);
          break;
        case PublicationLinkRelationship.thumbnail:
          priorityList.add(link);
          break;
        default:
      }
    }

    if (priorityList.isEmpty) {
      return null;
    } else {
      final PublicationLink cover = priorityList.first;
      return Expanded(
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: SharedBookCoverWidget(
            coverData: BookCover(
              identifier: cover.href.toString(),
              url: cover.href,
            ),
          ),
        ),
      );
    }
  }
}
