import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:music_player/models/gallery_model.dart';
import 'package:music_player/providers/gallery_provider.dart';
import 'package:music_player/providers/images_provider.dart';
import 'package:music_player/providers/user_provider.dart';
import 'package:music_player/shared/theme.dart';
import 'package:music_player/widgets/image_popup.dart';
import 'package:provider/provider.dart';

import 'photo_view_page.dart';

class DetailGalleryPage extends StatelessWidget {
  const DetailGalleryPage({required this.gallery, super.key});

  final GalleryModel gallery;

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    GalleryProvider galleryProvider = Provider.of<GalleryProvider>(context);
    ImagesProvider imagesProvider = Provider.of<ImagesProvider>(context);

    Future<void> handleAddImage() async {
      await imagesProvider.pickImage();
      await imagesProvider.cropImage(imageFile: imagesProvider.imageFile);
      showDialog(
        context: context,
        builder: (context) => ImagePopUp(
          add: () async {
            if (await galleryProvider.addImageGallery(
                galleryId: gallery.id,
                imagePath: imagesProvider.croppedImagePath)) {
              ScaffoldMessenger.of(context).removeCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: successColor,
                  content: const Text(
                    'Add image successfuly',
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            } else {
              ScaffoldMessenger.of(context).removeCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: alertColor,
                  content: Text(
                    galleryProvider.errorMessage,
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }
          },
        ),
      );
    }

    Widget header() {
      return SliverPadding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        sliver: SliverAppBar(
          stretch: true,
          elevation: 0,
          automaticallyImplyLeading: false,
          titleSpacing: 0,
          title: Padding(
            padding: EdgeInsets.symmetric(horizontal: defaultMargin),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back,
                    color: userProvider.user.role == "USER"
                        ? primaryUserColor
                        : primaryAdminColor,
                  ),
                ),
                Text(
                  gallery.name,
                  style: userProvider.user.role == "USER"
                      ? primaryUserColorText.copyWith(
                          fontWeight: bold,
                          fontSize: 20,
                        )
                      : primaryAdminColorText.copyWith(
                          fontWeight: bold,
                          fontSize: 20,
                        ),
                ),
              ],
            ),
          ),
          backgroundColor: userProvider.user.role == "USER"
              ? backgroundUserColor
              : backgroundAdminColor,
          floating: true,
          snap: true,
        ),
      );
    }

    Widget gridImages() {
      return GridView.builder(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        padding: const EdgeInsets.all(1),
        itemCount: gallery.images.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemBuilder: ((context, index) {
          return Container(
            padding: const EdgeInsets.all(0.5),
            child: InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      PhotoViewPage(images: gallery.images, index: index),
                ),
              ),
              child: Hero(
                tag: gallery.images[index],
                child: CachedNetworkImage(
                  imageUrl: gallery.images[index].url,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(color: Colors.grey),
                  errorWidget: (context, url, error) => Container(
                    color: Colors.red.shade400,
                  ),
                ),
              ),
            ),
          );
        }),
      );
    }

    return Scaffold(
      backgroundColor: userProvider.user.role == "USER"
          ? backgroundUserColor
          : backgroundAdminColor,
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
      floatingActionButton: Visibility(
        visible: userProvider.user.role != "USER",
        child: FloatingActionButton(
          onPressed: () async {
            await handleAddImage();
          },
          backgroundColor: secondaryColor,
          child: const Icon(
            Icons.add,
            size: 30,
          ),
        ),
      ),
    );
  }
}
