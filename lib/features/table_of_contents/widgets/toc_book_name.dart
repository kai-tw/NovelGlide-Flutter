import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/toc_bloc.dart';

class TocBookName extends StatelessWidget {
  const TocBookName({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(36.0, 0, 36.0, 24.0),
      child: BlocBuilder<TocCubit, TocState>(
        builder: (BuildContext context, TocState state) {
          return BlocBuilder<TocCubit, TocState>(
            builder: (BuildContext context, TocState state) {
              return Text(
                state.bookName,
                style: Theme.of(context).textTheme.titleLarge,
              );
            },
          );
        },
      ),
    );
  }
}
