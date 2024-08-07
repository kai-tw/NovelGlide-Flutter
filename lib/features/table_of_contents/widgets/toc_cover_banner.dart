import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../processor/book_processor.dart';
import '../../common_components/common_book_cover_image.dart';
import '../bloc/toc_bloc.dart';

class TocCoverBanner extends StatelessWidget {
  final double? aspectRatio;

  const TocCoverBanner({super.key, this.aspectRatio});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return BlocBuilder<TocCubit, TocState>(
          builder: (context, state) {
            return Hero(
              tag: state.bookName,
              child: Container(
                width: constraints.maxWidth,
                height: constraints.maxHeight,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  borderRadius: const BorderRadius.all(Radius.circular(24.0)),
                ),
                clipBehavior: Clip.hardEdge,
                child: CommonBookCoverImage(path: BookProcessor.getCoverPathByName(state.bookName)),
              ),
            );
          }
        );
      },
    );
  }
}