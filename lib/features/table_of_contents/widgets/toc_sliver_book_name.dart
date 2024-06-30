import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/toc_bloc.dart';

class TOCSliverBookName extends StatelessWidget {
  const TOCSliverBookName({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.fromLTRB(36.0, 0, 24.0, 24.0),
        child: BlocBuilder<TOCCubit, TOCState>(
          builder: (BuildContext context, TOCState state) {
            return BlocBuilder<TOCCubit, TOCState>(
              builder: (BuildContext context, TOCState state) {
                return Text(
                  state.bookName,
                  style: Theme.of(context).textTheme.titleLarge,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
