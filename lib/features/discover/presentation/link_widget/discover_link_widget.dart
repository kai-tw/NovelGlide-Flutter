import 'package:flutter/material.dart';

import '../../../../core/mime_resolver/domain/entities/mime_type.dart';
import '../../domain/entities/publication_link.dart';

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
    return TextButton.icon(
      onPressed: link.href == null
          ? null
          : switch (link.type) {
              MimeType.atomFeed => () => onVisit?.call(link.href!),
              MimeType.epub => () => onDownload?.call(link.href!),
              _ => null,
            },
      icon: switch (link.type) {
        MimeType.atomFeed => const Icon(Icons.link_rounded),
        MimeType.epub => const Icon(Icons.download_rounded),
        _ => const Icon(Icons.question_mark_rounded),
      },
      label: Text(switch (link.type) {
        MimeType.atomFeed => 'View',
        MimeType.epub => 'Download',
        _ => 'Unknown link',
      }),
    );
  }
}
