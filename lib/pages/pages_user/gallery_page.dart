import 'package:flutter/material.dart';
import 'package:music_player/pages/pages_user/detail_gallery_page.dart';
import 'package:music_player/pages/pages_user/empty_album_page.dart';
import 'package:music_player/shared/theme.dart';
import 'package:music_player/widgets/custom_button.dart';

class GalleryPage extends StatelessWidget {
  const GalleryPage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget albumGrid() {
      return Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DetailGalleryPage()));
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Image.asset(
                  "assets/ex_gallery.png",
                  width: 160,
                  height: 160,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Album Name",
                  style: primaryColorText.copyWith(
                      fontSize: 16, fontWeight: medium),
                ),
                Text(
                  "4736",
                  style: primaryColorText.copyWith(fontSize: 12),
                )
              ],
            ),
          ],
        ),
      );
    }

    Widget content() {
      return Expanded(
        child: GridView(
          padding: const EdgeInsets.only(top: 24, bottom: 100),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, childAspectRatio: 1 / 1.2),
          children: [
            albumGrid(),
            albumGrid(),
            albumGrid(),
            albumGrid(),
            albumGrid(),
            albumGrid(),
            albumGrid(),
            albumGrid()
          ],
        ),
      );
    }

    return Scaffold(
        backgroundColor: backgroundColor, body: SafeArea(child: content()));
  }
}
