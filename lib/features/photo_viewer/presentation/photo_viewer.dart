import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

import '../../../generated/i18n/app_localizations.dart';

class PhotoViewer extends StatelessWidget {
  const PhotoViewer({
    super.key,
    this.imageUrl,
    this.assetImagePath,
    this.imagePath,
    this.imageBytes,
  });

  final String? imageUrl;
  final String? assetImagePath;
  final String? imagePath;
  final Uint8List? imageBytes;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(appLocalizations.photoViewer),
      ),
      body: PhotoView(
        imageProvider: _buildImage(),
        minScale: PhotoViewComputedScale.contained,
      ),
    );
  }

  ImageProvider<Object> _buildImage() {
    if (imageUrl != null) {
      return NetworkImage(imageUrl!);
    }

    if (assetImagePath != null) {
      return AssetImage(assetImagePath!);
    }

    if (imagePath != null) {
      return FileImage(File(imagePath!));
    }

    if (imageBytes != null) {
      return MemoryImage(imageBytes!);
    }

    throw Exception('No image source provided.');
  }
}
