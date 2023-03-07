import 'package:flutter/material.dart';
import 'package:music_player/shared/theme.dart';
import 'package:music_player/widgets/custom_button.dart';

class EmptyGalleryPage extends StatelessWidget {
  const EmptyGalleryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
}
