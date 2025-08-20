import 'package:flutter/material.dart';

import '../../../locale_system/locale_utils.dart';
import '../../domain/entities/publication_author.dart';
import '../../domain/entities/publication_entry.dart';
import '../link_widget/discover_link_widget.dart';

class DiscoverEntryWidget extends StatelessWidget {
  const DiscoverEntryWidget({
    super.key,
    required this.entry,
    this.onVisit,
  });

  final PublicationEntry entry;
  final Future<void> Function(Uri uri)? onVisit;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget?>[
            _buildCardIcon(context),
            _buildTitle(context),
            _buildAuthors(context),
            _buildSummary(context),
            _buildPublishedDate(context),
            _buildPublisher(context),
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
    if (entry.summary == null) {
      return null;
    } else {
      return Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Text(entry.summary!),
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
    if (entry.links.firstOrNull == null) {
      return null;
    } else {
      return DiscoverLinkWidget(
        link: entry.links.firstOrNull!,
        onVisit: onVisit,
      );
    }
  }
}
