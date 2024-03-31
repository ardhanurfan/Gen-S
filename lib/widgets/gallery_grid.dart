// ignore_for_file: use_build_context_synchronously

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:music_player/models/gallery_model.dart';
import 'package:music_player/providers/gallery_provider.dart';
import 'package:music_player/providers/user_provider.dart';
import 'package:music_player/widgets/custom_popup.dart';
import 'package:music_player/widgets/default_image.dart';
import 'package:music_player/widgets/delete_popup.dart';
import 'package:provider/provider.dart';

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
    double deviceWidth = MediaQuery.of(context).size.width;
    UserProvider userProvider = Provider.of<UserProvider>(context);
    GalleryProvider galleryProvider = Provider.of<GalleryProvider>(context);
    TextEditingController galleryController =
        TextEditingController(text: gallery.name);

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
              ? DefaultImage(
                  type: ImageType.gallery,
                  size: deviceWidth <= kMobileBreakpoint ? 160 : 340)
              : ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: CachedNetworkImage(
                    imageUrl: gallery.images[0].url,
                    height: deviceWidth <= kMobileBreakpoint ? 160 : 340,
                    width: deviceWidth <= kMobileBreakpoint ? 160 : 340,
                    fit: BoxFit.cover,
                  ),
                ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      gallery.name,
                      style: userProvider.user?.role == "USER" ||
                              userProvider.user == null
                          ? primaryUserColorText.copyWith(
                              fontSize:
                                  deviceWidth <= kMobileBreakpoint ? 16 : 24,
                              fontWeight: medium,
                              overflow: TextOverflow.ellipsis)
                          : primaryAdminColorText.copyWith(
                              fontSize:
                                  deviceWidth <= kMobileBreakpoint ? 16 : 24,
                              fontWeight: medium,
                              overflow: TextOverflow.ellipsis),
                    ),
                    Text(
                      gallery.images.length.toString(),
                      style: userProvider.user?.role == "USER" ||
                              userProvider.user == null
                          ? primaryUserColorText.copyWith(
                              fontSize:
                                  deviceWidth <= kMobileBreakpoint ? 12 : 16,
                              overflow: TextOverflow.ellipsis)
                          : primaryAdminColorText.copyWith(
                              fontSize:
                                  deviceWidth <= kMobileBreakpoint ? 12 : 16,
                              overflow: TextOverflow.ellipsis),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: userProvider.user != null &&
                    userProvider.user?.role == "ADMIN" &&
                    gallery.name != "root",
                child: PopupMenuButton(
                  icon: Icon(
                    Icons.more_vert,
                    color: primaryAdminColor,
                  ),
                  color: const Color.fromARGB(255, 223, 223, 223),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(defaultRadius),
                  ),
                  elevation: 4,
                  onSelected: (value) {
                    if (value == 0) {
                      showDialog(
                        context: context,
                        builder: (context) => CustomPopUp(
                          title: "Playlist Name",
                          controller: galleryController,
                          add: () async {
                            if (await galleryProvider.renameGallery(
                                name: galleryController.text,
                                galleryId: gallery.id)) {
                              ScaffoldMessenger.of(context)
                                  .removeCurrentSnackBar();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: successColor,
                                  content: const Text(
                                    'Rename gallery successfuly',
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
                        ),
                      );
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) => DeletePopUp(
                          delete: () async {
                            if (await galleryProvider.deleteGallery(
                                galleryId: gallery.id)) {
                              ScaffoldMessenger.of(context)
                                  .removeCurrentSnackBar();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: successColor,
                                  content: const Text(
                                    'Delete gallery successfuly',
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
                        ),
                      );
                    }
                  },
                  itemBuilder: (BuildContext context) => [
                    PopupMenuItem(
                      value: 0,
                      child: Center(
                        child: Text(
                          'Rename',
                          style: primaryAdminColorText,
                        ),
                      ),
                    ),
                    PopupMenuItem(
                        value: 1,
                        child: Center(
                          child: Text(
                            "Delete",
                            style: primaryAdminColorText,
                          ),
                        ))
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
