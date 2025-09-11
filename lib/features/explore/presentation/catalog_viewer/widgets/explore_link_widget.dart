import 'package:flutter/material.dart';

import '../../../../../core/mime_resolver/domain/entities/mime_type.dart';
import '../../../../../core/mime_resolver/presentation/mime_icon.dart';
import '../../../../../generated/i18n/app_localizations.dart';
import '../../../../photo_viewer/presentation/photo_viewer.dart';
import '../../../domain/entities/publication_link.dart';

class ExploreLinkWidget extends StatelessWidget {
  const ExploreLinkWidget({
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
      onPressed: _buildOnPressed(context),
      icon: _buildIcon(),
      label: Text(_getTitle(appLocalizations)),
    );
  }

  void Function()? _buildOnPressed(BuildContext context) {
    if (link.href == null) {
      return null;
    }

    switch (link.type) {
      case MimeType.atomFeed:
        return () => onVisit?.call(link.href!);
      case MimeType.jpg:
        return () => Navigator.of(context).push(MaterialPageRoute<void>(
              builder: (BuildContext context) => PhotoViewer(
                imageUrl: link.href!.toString(),
              ),
            ));
      default:
    }

    if (link.rel == PublicationLinkRelationship.acquisition &&
        link.type == MimeType.epub) {
      return () => onDownload?.call(link.href!);
    }

    return null;
  }

  Widget _buildIcon() {
    if (link.type != null) {
      return MimeIcon(mimeType: link.type!);
    }

    return const Icon(Icons.question_mark_rounded);
  }

  String _getTitle(AppLocalizations appLocalizations) {
    if (link.title?.isNotEmpty == true) {
      return link.title!;
    }

    switch (link.type) {
      case MimeType.atomFeed:
        return appLocalizations.exploreBrowserViewIt;
      case MimeType.epub:
        return appLocalizations.exploreBrowserDownloadIt;
      default:
    }

    switch (link.rel) {
      case PublicationLinkRelationship.thumbnail:
        return appLocalizations.generalThumbnail;
      case PublicationLinkRelationship.cover:
        return appLocalizations.generalBookCover;
      default:
    }

    return appLocalizations.exploreBrowserUnknownLink;
  }
}
