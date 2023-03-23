import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:music_player/models/gallery_model.dart';
import 'package:music_player/models/image_model.dart';
import 'package:music_player/providers/gallery_provider.dart';
import 'package:music_player/providers/images_provider.dart';
import 'package:music_player/providers/user_provider.dart';
import 'package:music_player/shared/theme.dart';
import 'package:music_player/widgets/delete_popup.dart';
import 'package:music_player/widgets/image_popup.dart';
import 'package:provider/provider.dart';

import 'photo_view_page.dart';

class DetailGalleryPage extends StatefulWidget {
  const DetailGalleryPage({required this.gallery, super.key});

  final GalleryModel gallery;

  @override
  State<DetailGalleryPage> createState() => _DetailGalleryPageState();
}

class _DetailGalleryPageState extends State<DetailGalleryPage> {
  bool isDelete = false;
  List<ImageModel> imagesDel = [];

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    GalleryProvider galleryProvider = Provider.of<GalleryProvider>(context);
    ImagesProvider imagesProvider = Provider.of<ImagesProvider>(context);

    Future<void> handleAddImage() async {
      imagesProvider.setCroppedImageFile = null;
      await imagesProvider.pickImage();
      await imagesProvider.cropImage(imageFile: imagesProvider.imageFile);
      if (imagesProvider.croppedImageFile != null) {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => ImagePopUp(
            add: () async {
              if (await galleryProvider.addImageGallery(
                  galleryId: widget.gallery.id,
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
    }

    Future<void> handleDeleteImage() async {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => DeletePopUp(
          delete: () async {
            if (await galleryProvider.deleteImageGallery(
                imagesDel: imagesDel, galleryId: widget.gallery.id)) {
              ScaffoldMessenger.of(context).removeCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: successColor,
                  content: const Text(
                    'Delete images successfuly',
                    textAlign: TextAlign.center,
                  ),
                ),
              );
              setState(() {
                isDelete = false;
                imagesDel = [];
              });
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
                  isDelete ? 'Delete Images' : widget.gallery.name,
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
        itemCount: widget.gallery.images.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemBuilder: ((context, index) {
          return Container(
            padding: const EdgeInsets.all(0.5),
            child: InkWell(
              onTap: () {
                if (isDelete) {
                  setState(() {
                    if (imagesDel.contains(widget.gallery.images[index])) {
                      imagesDel.remove(widget.gallery.images[index]);
                    } else {
                      imagesDel.add(widget.gallery.images[index]);
                    }
                  });
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => PhotoViewPage(
                          images: widget.gallery.images, index: index),
                    ),
                  );
                }
              },
              child: Hero(
                tag: widget.gallery.images[index],
                child: Stack(
                  children: [
                    CachedNetworkImage(
                      width: double.infinity,
                      height: double.infinity,
                      imageUrl: widget.gallery.images[index].url,
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          Container(color: Colors.grey),
                      errorWidget: (context, url, error) => Container(
                        color: Colors.red.shade400,
                      ),
                    ),
                    Visibility(
                      visible: imagesDel.contains(widget.gallery.images[index]),
                      child: Container(
                        alignment: Alignment.center,
                        color: Colors.black45,
                        child: Icon(
                          Icons.check,
                          size: 40,
                          color: primaryUserColor,
                        ),
                      ),
                    )
                  ],
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
        child: Wrap(
          direction: Axis.vertical,
          children: [
            FloatingActionButton(
              heroTag: '1',
              onPressed: () async {
                if (isDelete) {
                  await handleDeleteImage();
                } else {
                  setState(() {
                    isDelete = true;
                  });
                }
              },
              backgroundColor: isDelete ? alertColor : secondaryColor,
              child: const Icon(
                Icons.delete,
                size: 30,
              ),
            ),
            const SizedBox(height: 16),
            FloatingActionButton(
              heroTag: '2',
              onPressed: () async {
                if (isDelete) {
                  setState(() {
                    isDelete = false;
                    imagesDel = [];
                  });
                } else {
                  await handleAddImage();
                }
              },
              backgroundColor: isDelete ? successColor : secondaryColor,
              child: isDelete
                  ? const Icon(
                      Icons.close,
                      size: 30,
                    )
                  : const Icon(
                      Icons.add,
                      size: 30,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
