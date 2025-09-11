import 'package:flutter/material.dart';

import '../../../../../enum/window_size.dart';
import '../../../../books/domain/entities/book_cover.dart';
import '../../../../books/presentation/book_cover/shared_book_cover_widget.dart';
import '../../../../photo_viewer/presentation/photo_viewer.dart';
import '../../../domain/entities/publication_link.dart';

class ExploreThumbnailWidget extends StatelessWidget {
  const ExploreThumbnailWidget({
    super.key,
    required this.entryLinks,
  });

  final List<PublicationLink> entryLinks;

  @override
  Widget build(BuildContext context) {
    PublicationLinkRelationship? currentRel;
    PublicationLink? chosenLink;

    // Make sure the cover is prioritized over the thumbnail.
    for (final PublicationLink link in entryLinks) {
      switch (link.rel) {
        case PublicationLinkRelationship.cover:
          currentRel = PublicationLinkRelationship.cover;
          chosenLink ??= link;
          break;
        case PublicationLinkRelationship.thumbnail:
          if (currentRel != PublicationLinkRelationship.cover) {
            currentRel = PublicationLinkRelationship.thumbnail;
            chosenLink ??= link;
          }
          break;
        default:
      }
    }

    final double maxWidth = switch (WindowSize.of(context)) {
      WindowSize.compact => 100,
      WindowSize.medium => 150,
      WindowSize.expanded => 200,
      WindowSize.large => 250,
      WindowSize.extraLarge => 300,
    };

    return Container(
      padding: const EdgeInsets.only(left: 16.0),
      constraints: BoxConstraints(maxWidth: maxWidth),
      child: chosenLink?.href == null
          ? const Icon(Icons.feed, size: 48.0)
          : InkWell(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => PhotoViewer(
                    imageUrl: chosenLink!.href!.toString(),
                  ),
                ),
              ),
              child: SharedBookCoverWidget(
                coverData: BookCover(
                  identifier: chosenLink!.href.toString(),
                  url: chosenLink.href,
                ),
              ),
            ),
    );
  }
}
