import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class WebImageLoader extends StatelessWidget {
  final String blobId;
  final String imageUrl;
  final int imageHolderType; // 1 for ImageView, 2 for Layout background

  const WebImageLoader({
    super.key,
    required this.blobId,
    required this.imageUrl,
    this.imageHolderType = 1,
  });

  @override
  Widget build(BuildContext context) {
    if (blobId == "0") {
      // Return placeholder if blobId is invalid
      return _placeholderWidget();
    }

    return imageHolderType == 1
        ? _buildImageView()
        : _buildBackgroundContainer();
  }

  Widget _buildImageView() {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      placeholder: (context, url) => _placeholderWidget(),
      errorWidget: (context, url, error) => _errorWidget(),
      fit: BoxFit.cover,
    );
  }

  Widget _buildBackgroundContainer() {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: CachedNetworkImageProvider(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _placeholderWidget() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _errorWidget() {
    return const Center(
      child: Icon(
        Icons.broken_image,
        color: Colors.grey,
      ),
    );
  }
}
