// ignore_for_file: use_build_context_synchronously

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:music_player/models/gallery_model.dart';
import 'package:music_player/models/image_model.dart';
import 'package:music_player/providers/audio_provider.dart';
import 'package:music_player/providers/gallery_provider.dart';
import 'package:music_player/providers/images_provider.dart';
import 'package:music_player/providers/user_provider.dart';
import 'package:music_player/shared/theme.dart';
import 'package:music_player/widgets/custom_popup.dart';
import 'package:music_player/widgets/delete_popup.dart';
import 'package:music_player/widgets/gallery_grid.dart';
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
  bool isAdd = false;
  List<ImageModel> imagesDel = [];

  @override
  Widget build(BuildContext context) {
    TextEditingController galleryController = TextEditingController(text: "");
    double deviceWidth = MediaQuery.of(context).size.width;
    UserProvider userProvider = Provider.of<UserProvider>(context);
    GalleryProvider galleryProvider = Provider.of<GalleryProvider>(context);
    ImagesProvider imagesProvider = Provider.of<ImagesProvider>(context);
    AudioProvider audioProvider = Provider.of<AudioProvider>(context);

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
              String newPath = imagesProvider.imageFile!.path.split('/').last;
              if (await galleryProvider.addImageGallery(
                galleryId: widget.gallery.id,
                imagePath: imagesProvider.croppedImagePath,
                title: newPath,
              )) {
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
              audioProvider.deleteImageFromGallery(imagesDel: imagesDel);
              setState(() {
                isDelete = false;
                isAdd = false;
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
                    color: userProvider.user?.role == "USER" ||
                            userProvider.user == null
                        ? primaryUserColor
                        : primaryAdminColor,
                  ),
                ),
                Text(
                  isDelete ? 'Select Images' : widget.gallery.name,
                  style: userProvider.user?.role == "USER" ||
                          userProvider.user == null
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
          backgroundColor:
              userProvider.user?.role == "USER" || userProvider.user == null
                  ? backgroundUserColor
                  : backgroundAdminColor,
          floating: true,
          snap: true,
        ),
      );
    }

    Widget gridChildren() {
      return galleryProvider.allGalleries
              .where((element) => element.parentId == widget.gallery.id)
              .isNotEmpty
          ? GridView(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.only(
                  top: 24,
                  bottom: 24,
                  left: deviceWidth <= kMobileBreakpoint ? 20 : 80,
                  right: deviceWidth <= kMobileBreakpoint ? 20 : 80),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: deviceWidth <= kMobileBreakpoint ? 2 : 3,
                childAspectRatio:
                    deviceWidth <= kMobileBreakpoint ? 1 / 1.4 : 1 / 1.2,
                crossAxisSpacing: deviceWidth <= kMobileBreakpoint ? 30 : 10,
              ),
              children: galleryProvider.allGalleries
                  .where((element) => element.parentId == widget.gallery.id)
                  .map(
                    (gallery) => GalleryGrid(
                      gallery: gallery,
                    ),
                  )
                  .toList(),
            )
          : const SizedBox();
    }

    Widget gridImages() {
      return GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(1),
        itemCount: widget.gallery.images.length,
        shrinkWrap: true,
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
                tag: widget.gallery.images[index].id,
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
      backgroundColor:
          userProvider.user?.role == "USER" || userProvider.user == null
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
          body: ListView(children: [
            gridChildren(),
            gridImages(),
          ]),
        ),
      ),
      floatingActionButton: Visibility(
        visible: userProvider.user?.role != "USER" && userProvider.user != null,
        child: Wrap(
          direction: Axis.vertical,
          children: [
            FloatingActionButton(
              heroTag: '1',
              onPressed: () async {
                if (isDelete) {
                  await handleDeleteImage();
                } else {
                  if (isAdd) {
                    // ADD FOLDER
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return CustomPopUp(
                          controller: galleryController,
                          title: "Gallery Name",
                          add: () async {
                            if (await galleryProvider.addGallery(
                                parentId: widget.gallery.id,
                                name: galleryController.text)) {
                              ScaffoldMessenger.of(context)
                                  .removeCurrentSnackBar();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: successColor,
                                  content: const Text(
                                    'Add gallery successfuly',
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context)
                                  .removeCurrentSnackBar();
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
                        );
                      },
                    );
                  } else {
                    setState(() {
                      isDelete = true;
                    });
                  }
                }
              },
              backgroundColor: isDelete ? alertColor : successColor,
              child: isDelete
                  ? const Icon(
                      Icons.delete,
                      size: 30,
                    )
                  : isAdd
                      ? const Icon(
                          Icons.create_new_folder_outlined,
                          size: 30,
                        )
                      : const Icon(
                          Icons.edit,
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
                  if (isAdd) {
                    await handleAddImage();
                  } else {
                    setState(() {
                      isAdd = true;
                    });
                  }
                }
              },
              backgroundColor: isDelete ? primaryUserColor : secondaryColor,
              child: isDelete
                  ? Icon(
                      Icons.close,
                      color: primaryAdminColor,
                      size: 30,
                    )
                  : isAdd
                      ? const Icon(
                          Icons.add_a_photo_outlined,
                          size: 30,
                        )
                      : const Icon(
                          Icons.add,
                          size: 30,
                        ),
            ),
            SizedBox(height: isAdd ? 16 : 0),
            Visibility(
              visible: isAdd,
              child: FloatingActionButton(
                  heroTag: '3',
                  onPressed: () async {
                    if (isAdd) {
                      setState(() {
                        isAdd = false;
                      });
                    }
                  },
                  backgroundColor: primaryUserColor,
                  child: Icon(
                    Icons.close,
                    color: primaryAdminColor,
                    size: 30,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
