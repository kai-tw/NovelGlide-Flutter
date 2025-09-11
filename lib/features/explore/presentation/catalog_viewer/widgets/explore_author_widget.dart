import 'package:flutter/material.dart';

import '../../../domain/entities/publication_author.dart';

class ExploreAuthorWidget extends StatelessWidget {
  const ExploreAuthorWidget({
    super.key,
    required this.author,
    this.onVisit,
  });

  final PublicationAuthor author;
  final Future<void> Function(Uri uri)? onVisit;

  @override
  Widget build(BuildContext context) {
    if (author.name?.isNotEmpty == true) {
      return TextButton.icon(
        onPressed: author.uri == null || onVisit == null
            ? null
            : () => onVisit?.call(author.uri!),
        icon: const Icon(Icons.person),
        label: Text(author.name!),
        style: TextButton.styleFrom(
          foregroundColor: Theme.of(context).colorScheme.secondary,
          backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
          disabledForegroundColor: Theme.of(context).colorScheme.secondary,
          disabledBackgroundColor:
              Theme.of(context).colorScheme.surfaceContainerLow,
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
