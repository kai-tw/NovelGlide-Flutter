import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CommonDeleteDragTarget extends StatelessWidget {
  final bool Function(DragTargetDetails<Object>)? onWillAcceptWithDetails;

  const CommonDeleteDragTarget({super.key, this.onWillAcceptWithDetails});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return DragTarget(
      builder: (context, candidateData, rejectedData) {
        return Container(
          padding: const EdgeInsets.symmetric(
            vertical: 16.0,
            horizontal: 32.0,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.error,
            borderRadius: BorderRadius.circular(36.0),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).colorScheme.shadow.withValues(alpha: 0.5),
                offset: const Offset(0.0, 4.0),
                blurRadius: 8.0,
              ),
            ],
          ),
          clipBehavior: Clip.hardEdge,
          child: Row(
            // mainAxisSize: MainAxisSize.min,
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
                appLocalizations.generalDragHereToDelete,
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
