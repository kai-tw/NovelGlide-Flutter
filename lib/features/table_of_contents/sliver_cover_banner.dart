import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/toc_bloc.dart';

class TOCSliverCoverBanner extends StatelessWidget {
  const TOCSliverCoverBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24.0, 0, 24.0, 24.0),
        child: AspectRatio(
          aspectRatio: 1,
          child: BlocBuilder<TOCCubit, TOCState>(
            builder: (BuildContext context, TOCState state) {
              return Hero(
                tag: BlocProvider.of<TOCCubit>(context).bookObject.name,
                child: Container(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height / 2,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceVariant,
                    borderRadius: const BorderRadius.all(Radius.circular(24.0)),
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: BlocProvider.of<TOCCubit>(context).bookObject.getCover(),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

}