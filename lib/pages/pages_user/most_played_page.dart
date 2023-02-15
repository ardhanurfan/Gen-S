import 'package:flutter/material.dart';
import 'package:music_player/shared/theme.dart';

import '../../widgets/song_tile.dart';

class MostPlayedPage extends StatelessWidget {
  const MostPlayedPage({super.key});

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
            "Most Played",
            style: primaryColorText.copyWith(fontWeight: bold, fontSize: 24),
          )
        ],
      );
    }

    Widget listOfSong() {
      return Padding(
        padding: const EdgeInsets.only(top: 47),
        child: Column(
          children: [
            SongTile(isMostPlayed: true),
            SongTile(isMostPlayed: true),
            SongTile(isMostPlayed: true),
            SongTile(isMostPlayed: true),
            SongTile(isMostPlayed: true),
            SongTile(isMostPlayed: true),
            SongTile(isMostPlayed: true),
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
