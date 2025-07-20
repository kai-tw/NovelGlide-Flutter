import 'package:flutter/material.dart';

import '../../generated/i18n/app_localizations.dart';

class CommonDeleteDragTarget<T extends Object> extends StatelessWidget {
  const CommonDeleteDragTarget({super.key, this.onWillAcceptWithDetails});

  final bool Function(DragTargetDetails<Object>)? onWillAcceptWithDetails;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return DragTarget<T>(
      builder: (BuildContext context, List<T?> candidateData, List<dynamic> rejectedData) {
        return Container(
          padding: const EdgeInsets.symmetric(
            vertical: 16.0,
            horizontal: 32.0,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.error,
            borderRadius: BorderRadius.circular(36.0),
            boxShadow: <BoxShadow>[
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
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Icon(
                  Icons.delete_forever_rounded,
                  color: Theme.of(context).colorScheme.onError,
                ),
              ),
              Expanded(
                child: Text(
                  appLocalizations.generalDragHereToDelete,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onError,
                  ),
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
