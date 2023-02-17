import 'package:flutter/material.dart';
import 'package:music_player/shared/theme.dart';
import 'package:music_player/widgets/custom_button.dart';

class EmptyStatePage extends StatelessWidget {
  const EmptyStatePage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget backIcon() {
      return Padding(
        padding: EdgeInsets.only(top: defaultMargin, left: defaultMargin),
        child: Align(
          alignment: Alignment.topLeft,
          child: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.arrow_back_rounded,
                size: 30,
                color: primaryColor,
              )),
        ),
      );
    }

    Widget mainIcon() {
      return Container(
        margin: const EdgeInsets.only(top: 80),
        height: 260,
        width: 340,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/empty_state.png"),
                fit: BoxFit.contain)),
      );
    }

    Widget mainText() {
      return Center(
        child: Container(
          margin: const EdgeInsets.only(top: 49, bottom: 24),
          child: Text(
            "Your library is empty  :(",
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
            buttonText: "Add Audio",
            onPressed: () {},
            heightButton: 53),
      );
    }

    Widget content() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          backIcon(),
          mainIcon(),
          mainText(),
          addAudioButton(),
        ],
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(child: content()),
    );
  }
}
