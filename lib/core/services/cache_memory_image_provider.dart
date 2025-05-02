import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CacheMemoryImageProvider extends ImageProvider<CacheMemoryImageProvider> {
  CacheMemoryImageProvider(this.tag, this.img);

  final String tag;
  final Uint8List img;

  @override
  ImageStreamCompleter loadImage(
      CacheMemoryImageProvider key, ImageDecoderCallback decode) {
    return MultiFrameImageStreamCompleter(
      codec: _loadAsync(decode),
      scale: 1.0,
      debugLabel: tag,
      informationCollector: () sync* {
        yield ErrorDescription('Tag: $tag');
      },
    );
  }

  Future<Codec> _loadAsync(ImageDecoderCallback decode) async {
    final Uint8List bytes = img;

    if (bytes.lengthInBytes == 0) {
      PaintingBinding.instance.imageCache.evict(this);
      throw StateError('$tag is empty and cannot be loaded as an image.');
    }
    final ImmutableBuffer buffer = await ImmutableBuffer.fromUint8List(bytes);

    return await decode(buffer);
  }

  @override
  Future<CacheMemoryImageProvider> obtainKey(ImageConfiguration configuration) {
    return SynchronousFuture<CacheMemoryImageProvider>(this);
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is CacheMemoryImageProvider && other.tag == tag;
  }

  @override
  int get hashCode => tag.hashCode;

  @override
  String toString() =>
      '${objectRuntimeType(this, 'CacheImageProvider')}("$tag")';
}
