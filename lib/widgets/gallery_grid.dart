import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:music_player/models/gallery_model.dart';
import 'package:music_player/providers/user_provider.dart';
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
    UserProvider userProvider = Provider.of<UserProvider>(context);
<<<<<<< HEAD
    final itemWidth = MediaQuery.of(context).size.width;
=======
>>>>>>> 609880f4db4364dd44d7ba2ca3c5c373c7146d6f
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
                    height: 160,
                    width: 160,
                    fit: BoxFit.fill,
                  ),
                )
              : ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: CachedNetworkImage(
                    imageUrl: gallery.images[0].url,
                    height: 160,
                    width: 160,
                    fit: BoxFit.fill,
                  ),
                ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    gallery.name,
                    style: userProvider.user.role == "USER"
                        ? primaryUserColorText.copyWith(
                            fontSize: 16, fontWeight: medium)
                        : primaryAdminColorText.copyWith(
                            fontSize: 16, fontWeight: medium),
                  ),
                  Text(
                    gallery.images.length.toString(),
                    style: userProvider.user.role == "USER"
                        ? primaryUserColorText.copyWith(fontSize: 12)
                        : primaryAdminColorText.copyWith(fontSize: 12),
                  ),
                ],
              ),
              PopupMenuButton(
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
                        builder: (context) => DeletePopUp(delete: () {}));
                  }
                },
                itemBuilder: (BuildContext context) => [
                  PopupMenuItem(
                      value: 0,
                      child: Text(
                        "Delete",
                        style: primaryAdminColorText,
                      ))
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
