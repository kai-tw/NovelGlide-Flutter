import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common_components/common_book_cover_image.dart';
import '../bloc/toc_bloc.dart';

class TOCSliverCoverBanner extends StatelessWidget {
  const TOCSliverCoverBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final TOCCubit cubit = BlocProvider.of<TOCCubit>(context);
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.fromLTRB(24.0, 0, 24.0, 24.0),
        child: AspectRatio(
          aspectRatio: 1,
          child: BlocBuilder<TOCCubit, TOCState>(
            builder: (context, state) {
              return Hero(
                tag: cubit.bookData.name,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceContainerHighest,
                    borderRadius: const BorderRadius.all(Radius.circular(24.0)),
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: CommonBookCoverImage(path: cubit.bookData.getCoverPath()),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

}