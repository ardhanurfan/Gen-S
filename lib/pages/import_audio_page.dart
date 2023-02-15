import 'package:flutter/material.dart';
import 'package:music_player/shared/theme.dart';
import 'package:music_player/widgets/custom_button.dart';

class ImportAudioPage extends StatelessWidget {
  const ImportAudioPage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget backIcon() {
      return Padding(
        padding: EdgeInsets.only(top: defaultMargin),
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
        height: 250,
        width: 254,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/import_audio.png"),
                fit: BoxFit.contain)),
      );
    }

    Widget mainText() {
      return Center(
        child: Container(
          margin: const EdgeInsets.only(top: 49, bottom: 24),
          child: Text(
            "Too little? Add more!",
            style: primaryColorText.copyWith(fontSize: 24, fontWeight: bold),
          ),
        ),
      );
    }

    Widget addAudioButton() {
      return CustomButton(
          radiusButton: 32,
          buttonColor: secondaryColor,
          buttonText: "Add Audio",
          onPressed: () {},
          heightButton: 53);
    }

    Widget importOption() {
      return Container(
          margin: const EdgeInsets.only(top: 46),
          child: Column(
            children: [
              Text(
                "import from",
                style:
                    primaryColorText.copyWith(fontSize: 12, fontWeight: medium),
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                height: 24,
                width: 168,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/import_option.png"),
                        fit: BoxFit.fill)),
              )
            ],
          ));
    }

    Widget content() {
      return ListView(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        children: [
          backIcon(),
          mainIcon(),
          mainText(),
          addAudioButton(),
          importOption()
        ],
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(child: content()),
    );
  }
}
