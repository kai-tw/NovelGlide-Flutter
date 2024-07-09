import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../data/book_data.dart';

class HomepageBookDeleteDragTarget extends StatelessWidget {
  const HomepageBookDeleteDragTarget({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return LayoutBuilder(
      builder: (context, constraints) {
        return DragTarget(
          builder: (context, candidateData, rejectedData) {
            return Container(
              width: constraints.maxWidth,
              height: constraints.maxHeight,
              color: Theme.of(context).colorScheme.error,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Icon(
                      Icons.delete_forever_rounded,
                      color: Theme.of(context).colorScheme.onError,
                    ),
                  ),
                  Text(
                    appLocalizations.homepageDragHereToDelete,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onError,
                    ),
                  ),
                ],
              ),
            );
          },
          onWillAcceptWithDetails: (details) {
            return details.data is BookData;
          },
          onLeave: (_) {},
        );
      },
    );
  }
}