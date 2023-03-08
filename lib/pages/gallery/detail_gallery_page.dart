import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:music_player/models/gallery_model.dart';
import 'package:music_player/shared/theme.dart';

class DetailGalleryPage extends StatelessWidget {
  const DetailGalleryPage({required this.gallery, super.key});

  final GalleryModel gallery;

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return SliverPadding(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin, vertical: 20),
        sliver: SliverAppBar(
          stretch: true,
          elevation: 0,
          automaticallyImplyLeading: false,
          titleSpacing: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back,
                  color: primaryColor,
                ),
              ),
              Text(
                gallery.name,
                style: primaryColorText.copyWith(
                  fontWeight: bold,
                  fontSize: 20,
                ),
              ),
            ],
          ),
          backgroundColor: backgroundColor,
          floating: true,
          snap: true,
        ),
      );
    }

    Widget gridImages() {
      return GridView(
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
        children: gallery.images
            .map(
              (image) => ClipRRect(
                child: CachedNetworkImage(
                  imageUrl: image.url,
                ),
              ),
            )
            .toList(),
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              header(),
            ];
          },
          body: gridImages(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: secondaryColor,
        child: const Icon(
          Icons.add,
          size: 30,
        ),
      ),
    );
  }
}
