import 'package:flutter/material.dart';

import '../../../../../../generated/i18n/app_localizations.dart';
import '../../../../domain/entities/publication_link.dart';

class ExploreCatalogPaginationNextButton extends StatelessWidget {
  const ExploreCatalogPaginationNextButton({
    super.key,
    this.nextLink,
    this.onVisit,
  });

  final PublicationLink? nextLink;
  final Future<void> Function(Uri uri)? onVisit;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return TextButton(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(appLocalizations.generalNextPage),
          const Icon(Icons.navigate_next_rounded),
        ],
      ),
      onPressed: () async {
        if (nextLink?.href != null) {
          await onVisit?.call(nextLink!.href!);
        }
      },
    );
  }
}
