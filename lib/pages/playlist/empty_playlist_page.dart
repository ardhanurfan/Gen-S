import 'package:flutter/material.dart';

import '../../../shared/theme.dart';
import '../../../widgets/custom_button.dart';

class EmptyPlaylistPage extends StatelessWidget {
  const EmptyPlaylistPage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget mainIcon() {
      return Container(
        margin: const EdgeInsets.only(top: 120),
        height: 260,
        width: 340,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/playlist_empty.png"),
            fit: BoxFit.contain,
          ),
        ),
      );
    }

    Widget mainText() {
      return Center(
        child: Container(
          margin: const EdgeInsets.only(top: 49, bottom: 24),
          child: Text(
            "Your playlist is empty  :(",
            style: primaryColorText.copyWith(fontSize: 24, fontWeight: bold),
          ),
        ),
      );
    }

    Widget addAudioButton() {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: CustomButton(
          radiusButton: 32,
          buttonColor: secondaryColor,
          buttonText: "Create Playlist",
          onPressed: () {},
          heightButton: 53,
        ),
      );
    }

    Widget content() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          mainIcon(),
          mainText(),
          addAudioButton(),
        ],
      );
    }

    return content();
  }
}
