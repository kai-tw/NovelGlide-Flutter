import 'package:bitmap/bitmap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/cache_memory_image_provider.dart';
import '../../../../generated/i18n/app_localizations.dart';
import '../../../../main.dart';
import '../../domain/entities/book_cover.dart';
import 'cubit/book_cover_cubit.dart';

class BookCoverWidget extends StatelessWidget {
  const BookCoverWidget({
    super.key,
    required this.identifier,
    required this.fit,
  });

  final String identifier;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    final BookCoverCubit cubit = sl<BookCoverCubit>();
    return BlocProvider<BookCoverCubit>(
      create: (_) => cubit,
      child: FutureBuilder<BookCover>(
        future: cubit.startLoading(identifier),
        builder: (BuildContext context, AsyncSnapshot<BookCover> snapshot) {
          if (snapshot.hasData) {
            return _buildImage(context, snapshot.data!);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget _buildImage(BuildContext context, BookCover coverData) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    // Bytes are not null
    if (coverData.bytes != null && coverData.hasSize) {
      // Use bitmap to display the cover
      return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Image(
            image: CacheMemoryImageProvider(
              coverData.identifier,
              Bitmap.fromHeadless(
                coverData.width!.truncate(),
                coverData.height!.truncate(),
                coverData.bytes!,
              ).buildHeaded(),
            ),
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            fit: fit,
            semanticLabel: appLocalizations.generalBookCover,
          );
        },
      );
    }

    // Url are not empty
    if (coverData.url != null && coverData.hasSize) {
      // Load the network image
      // TODO(kai): Implementation.
    }

    // There is not an image. Use the image in the asset.
    final Brightness brightness = Theme.of(context).brightness;

    return Image.asset(
      'assets/images/book_cover_${brightness == Brightness.dark ? 'dark' : 'light'}.jpg',
      fit: BoxFit.cover,
      gaplessPlayback: true,
      semanticLabel: appLocalizations.generalBookCover,
    );
  }
}
