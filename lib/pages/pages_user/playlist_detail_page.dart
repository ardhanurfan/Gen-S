import 'package:flutter/material.dart';
import 'package:music_player/shared/theme.dart';
import 'package:music_player/widgets/audio_tile.dart';

class PlaylistDetailPage extends StatelessWidget {
  const PlaylistDetailPage({super.key});

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
            ),
          ),
          Icon(
            Icons.add,
            color: primaryColor,
          )
        ],
      );
    }

    Widget playlistInfo() {
      return Padding(
        padding: const EdgeInsets.only(top: 27, bottom: 37),
        child: Column(
          children: [
            Image.asset(
              "assets/ex_bg_playlist.png",
              width: 200,
              height: 200,
              alignment: Alignment.center,
            ),
            const SizedBox(
              height: 24,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Road Trip",
                  style:
                      primaryColorText.copyWith(fontSize: 20, fontWeight: bold),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(
                  width: 15,
                ),
                Icon(
                  Icons.more_horiz,
                  color: primaryColor,
                  size: 20,
                )
              ],
            ),
            Text(
              "12 Songs",
              style: primaryColorText.copyWith(fontSize: 12, fontWeight: light),
            )
          ],
        ),
      );
    }

    Widget content() {
      return ListView(
        padding: EdgeInsets.all(defaultMargin),
        children: [
          header(),
          playlistInfo(),
          AudioTile(isHome: true),
          AudioTile(isHome: true),
          AudioTile(isHome: true),
          AudioTile(isHome: true),
          AudioTile(isHome: true),
          AudioTile(isHome: true),
        ],
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(child: content()),
    );
  }
}
