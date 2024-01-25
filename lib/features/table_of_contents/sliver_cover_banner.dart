import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/toc_bloc.dart';

class TOCSliverCoverBanner extends StatelessWidget {
  const TOCSliverCoverBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.fromLTRB(24.0, 0, 24.0, 24.0),
        child: AspectRatio(
          aspectRatio: 1,
          child: BlocBuilder<TOCCubit, TOCState>(
            builder: (BuildContext context, TOCState state) {
              return Hero(
                tag: state.bookObject.name,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceVariant,
                    borderRadius: const BorderRadius.all(Radius.circular(24.0)),
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: state.bookObject.getCover(),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

}