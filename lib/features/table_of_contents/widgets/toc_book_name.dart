import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/toc_bloc.dart';

class TocBookName extends StatelessWidget {
  const TocBookName({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface.withOpacity(0.9),
        borderRadius: const BorderRadius.all(Radius.circular(16.0)),
      ),
      clipBehavior: Clip.hardEdge,
      child: BlocBuilder<TocCubit, TocState>(
        buildWhen: (previous, current) => previous.bookName != current.bookName,
        builder: (BuildContext context, TocState state) {
          return Text(
            state.bookName,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          );
        },
      ),
    );
  }
}
