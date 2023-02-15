import 'package:flutter/material.dart';
import 'package:music_player/shared/theme.dart';

class RecentlyPlayedPage extends StatelessWidget {
  const RecentlyPlayedPage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back,
                color: primaryColor,
              )),
          Text(
            "Recently Played",
            style: primaryColorText.copyWith(fontWeight: bold, fontSize: 24),
          )
        ],
      );
    }

    Widget songTile() {
      return Container(
        margin: const EdgeInsets.only(bottom: 24),
        child: Row(
          children: [
            Container(
              height: 60,
              margin: const EdgeInsets.only(right: 24),
              width: 60,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/bg_song_example.png"),
                      fit: BoxFit.fill)),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 178,
                  child: Text(
                    "Locked Out of Heaven",
                    overflow: TextOverflow.clip,
                    style: primaryColorText.copyWith(
                        fontSize: 16, fontWeight: bold),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                SizedBox(
                  width: 178,
                  child: Text(
                    "Bruno Mars",
                    style: primaryColorText.copyWith(
                        fontSize: 16, fontWeight: regular),
                  ),
                ),
              ],
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {},
              child: Icon(
                Icons.play_circle,
                color: primaryColor,
              ),
            )
          ],
        ),
      );
    }

    Widget listOfSong() {
      return Padding(
        padding: const EdgeInsets.only(top: 47),
        child: Column(
          children: [
            songTile(),
            songTile(),
            songTile(),
            songTile(),
            songTile(),
            songTile(),
            songTile(),
            songTile(),
            songTile(),
            songTile(),
            songTile(),
            songTile(),
          ],
        ),
      );
    }

    Widget content() {
      return ListView(
        padding: EdgeInsets.symmetric(
            horizontal: defaultMargin, vertical: defaultMargin),
        children: [header(), listOfSong()],
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(child: content()),
    );
  }
}
