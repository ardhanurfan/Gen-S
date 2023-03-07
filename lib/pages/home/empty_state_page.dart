import 'package:flutter/material.dart';
import 'package:music_player/shared/theme.dart';

class EmptyStatePage extends StatelessWidget {
  const EmptyStatePage({super.key});

  @override
  Widget build(BuildContext context) {
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

    return Column(
      children: [
        mainIcon(),
        mainText(),
      ],
    );
  }
}
