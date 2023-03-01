import 'package:flutter/material.dart';
import 'package:music_player/shared/theme.dart';
import 'package:music_player/widgets/custom_button.dart';

class GalleryPage extends StatelessWidget {
  const GalleryPage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget content() {
      return ListView(
        padding: EdgeInsets.all(defaultMargin),
        children: [
          Text(
            "Album Name",
            textAlign: TextAlign.end,
            style: primaryColorText.copyWith(fontSize: 20, fontWeight: bold),
          ),
          Container(
            margin: const EdgeInsets.only(top: 100, bottom: 69),
            child: Image.asset(
              "assets/empty_gallery.png",
              width: 345,
              height: 184,
            ),
          ),
          Text(
            "Nothing here",
            textAlign: TextAlign.center,
            style: primaryColorText.copyWith(fontSize: 20, fontWeight: bold),
          ),
          const SizedBox(
            height: 22,
          ),
          CustomButton(
              radiusButton: 32,
              buttonColor: secondaryColor,
              buttonText: "Add Picture",
              onPressed: () {},
              heightButton: 53)
        ],
      );
    }

    return Scaffold(
        backgroundColor: backgroundColor, body: SafeArea(child: content()));
  }
}
