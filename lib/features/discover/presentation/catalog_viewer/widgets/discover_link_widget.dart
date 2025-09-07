import 'package:flutter/material.dart';

import '../../../../../core/mime_resolver/domain/entities/mime_type.dart';
import '../../../../../core/mime_resolver/presentation/mime_icon.dart';
import '../../../../../generated/i18n/app_localizations.dart';
import '../../../domain/entities/publication_link.dart';

class DiscoverLinkWidget extends StatelessWidget {
  const DiscoverLinkWidget({
    super.key,
    required this.link,
    this.onVisit,
    this.onDownload,
  });

  final PublicationLink link;
  final Future<void> Function(Uri uri)? onVisit;
  final Future<void> Function(Uri uri)? onDownload;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return TextButton.icon(
      onPressed: link.href == null
          ? null
          : switch (link.type) {
              MimeType.atomFeed => () => onVisit?.call(link.href!),
              MimeType.epub => () => onDownload?.call(link.href!),
              _ => null,
            },
      icon: _buildIcon(),
      label: Text(_getTitle(appLocalizations)),
    );
  }

  Widget _buildIcon() {
    if (link.type != null) {
      return MimeIcon(mimeType: link.type!);
    }

    return const Icon(Icons.question_mark_rounded);
  }

  String _getTitle(AppLocalizations appLocalizations) {
    if (link.title != null) {
      return link.title!;
    }

    switch (link.type) {
      case MimeType.atomFeed:
        return appLocalizations.discoverBrowserViewIt;
      case MimeType.epub:
        return appLocalizations.discoverBrowserDownloadIt;
      default:
    }

    switch (link.rel) {
      case PublicationLinkRelationship.thumbnail:
        return appLocalizations.generalThumbnail;
      case PublicationLinkRelationship.cover:
        return appLocalizations.generalBookCover;
      default:
    }

    return appLocalizations.discoverBrowserUnknownLink;
  }
}
