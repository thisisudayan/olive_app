// multiple images url but show only 3 in stack
// fallback image asset
// default image asset

import 'dart:math' as math;
import 'package:flutter/material.dart';

class SquircleImageGroup extends StatelessWidget {
  final List<String>? imageUrls;
  final String? fallbackImageUrl;
  final String defaultImageUrl;
  final double size;

  const SquircleImageGroup({
    super.key,
    this.imageUrls,
    this.fallbackImageUrl,
    required this.defaultImageUrl,
    this.size = 48,
  });

  @override
  Widget build(BuildContext context) {
    final images = (imageUrls == null || imageUrls!.isEmpty)
        ? [defaultImageUrl]
        : imageUrls!.take(3).toList();

    return SizedBox(
      width: size + (images.length - 1) * 6,
      height: size,
      child: Stack(
        children: List.generate(images.length, (i) {
          final index = images.length - 1 - i;

          return Positioned(
            left: index * 6,
            child: Transform(
              alignment: Alignment.bottomCenter,
              transform: Matrix4.rotationZ(index * (5 * math.pi / 180)),
              child: _SquircleImage(
                imageUrl: images[index],
                fallbackImageUrl: fallbackImageUrl,
                defaultImageUrl: defaultImageUrl,
                size: size,
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _SquircleImage extends StatelessWidget {
  final String imageUrl;
  final String? fallbackImageUrl;
  final String defaultImageUrl;
  final double size;

  const _SquircleImage({
    required this.imageUrl,
    this.fallbackImageUrl,
    required this.defaultImageUrl,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: ShapeBorderClipper(
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(28),
        ),
      ),
      child: Image.network(
        imageUrl,
        width: size,
        height: size,
        fit: BoxFit.cover,
        errorBuilder: (_, _, _) {
          return Image.asset(
            fallbackImageUrl ?? defaultImageUrl,
            width: size,
            height: size,
            fit: BoxFit.cover,
          );
        },
        loadingBuilder:
            (
              BuildContext context,
              Widget child,
              ImageChunkEvent? loadingProgress,
            ) {
              return Center(
                child: Container(
                  width: size,
                  height: size,
                  color: Colors.grey[200],
                  child: child,
                ),
              );
            },
      ),
    );
  }
}
