import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CommonDeleteDragTarget extends StatelessWidget {
  final bool Function(DragTargetDetails<Object>)? onWillAcceptWithDetails;

  const CommonDeleteDragTarget({super.key, this.onWillAcceptWithDetails});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return DragTarget(
      builder: (context, candidateData, rejectedData) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.error,
            borderRadius: BorderRadius.circular(36.0),
          ),
          clipBehavior: Clip.hardEdge,
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
                appLocalizations.commonDragHereToDelete,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onError,
                ),
              ),
            ],
          ),
        );
      },
      onWillAcceptWithDetails: onWillAcceptWithDetails,
    );
  }
}