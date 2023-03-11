import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:music_player/models/gallery_model.dart';

import '../pages/gallery/detail_gallery_page.dart';
import '../shared/theme.dart';

class GalleryGrid extends StatelessWidget {
  const GalleryGrid({
    required this.gallery,
    Key? key,
  }) : super(key: key);

  final GalleryModel gallery;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailGalleryPage(gallery: gallery),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          gallery.images.isEmpty
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Image.asset(
                    "assets/ex_gallery.png",
                  ),
                )
              : ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: CachedNetworkImage(
                    imageUrl: gallery.images[0].url,
                    fit: BoxFit.cover,
                  ),
                ),
          Text(
            gallery.name,
            style: primaryColorText.copyWith(fontSize: 16, fontWeight: medium),
          ),
          Text(
            gallery.images.length.toString(),
            style: primaryColorText.copyWith(fontSize: 12),
          ),
        ],
      ),
    );
  }
}
