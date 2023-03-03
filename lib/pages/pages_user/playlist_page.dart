import 'package:flutter/material.dart';
import 'package:music_player/shared/theme.dart';

import '../../widgets/custom_button.dart';

class PlaylistPage extends StatelessWidget {
  const PlaylistPage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return SliverPadding(
        padding:
            EdgeInsets.only(right: defaultMargin, left: defaultMargin, top: 24),
        sliver: SliverAppBar(
          stretch: true,
          elevation: 0,
          automaticallyImplyLeading: false,
          titleSpacing: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    "Playlist",
                    style: primaryColorText.copyWith(
                        fontSize: 24, fontWeight: bold),
                  ),
                  const SizedBox(
                    width: 21,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: RotatedBox(
                      quarterTurns: 1,
                      child: Icon(
                        Icons.compare_arrows,
                        size: 28,
                        color: primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(
                    Icons.add,
                    size: 36,
                    color: primaryColor,
                  ),
                  const SizedBox(width: 16),
                  Icon(
                    Icons.settings_outlined,
                    size: 32,
                    color: primaryColor,
                  )
                ],
              ),
            ],
          ),
          backgroundColor: backgroundColor,
          floating: true,
          snap: true,
        ),
      );
    }

    Widget mainIcon() {
      return Container(
        margin: const EdgeInsets.only(top: 80, right: 30),
        height: 260,
        width: 340,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/playlist_empty.png"),
                fit: BoxFit.contain)),
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
            heightButton: 53),
      );
    }

    Widget content() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          mainIcon(),
          mainText(),
          addAudioButton(),
        ],
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              header(),
            ];
          },
          body: content(),
        ),
      ),
    );
  }
}
