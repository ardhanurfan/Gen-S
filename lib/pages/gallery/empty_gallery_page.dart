import 'package:flutter/material.dart';
import 'package:music_player/shared/theme.dart';

class EmptyGalleryPage extends StatelessWidget {
  const EmptyGalleryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 120, bottom: 70),
              child: Image.asset(
                "assets/empty_gallery.png",
                width: 345,
                height: 184,
              ),
            ),
            Text(
              "Nothing pictures here :(",
              textAlign: TextAlign.center,
              style: primaryColorText.copyWith(fontSize: 20, fontWeight: bold),
            ),
          ],
        ),
      ),
    );
  }
}
