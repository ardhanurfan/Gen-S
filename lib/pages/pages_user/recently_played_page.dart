import 'package:flutter/material.dart';
import 'package:music_player/shared/theme.dart';
import 'package:music_player/widgets/song_tile.dart';

class RecentlyPlayedPage extends StatelessWidget {
  const RecentlyPlayedPage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin, vertical: 24),
        child: Row(
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
        ),
      );
    }

    Widget listOfSong() {
      return Expanded(
        child: ListView(
          padding:
              EdgeInsets.symmetric(horizontal: defaultMargin, vertical: 24),
          children: [
            const SongTile(),
            const SongTile(),
            const SongTile(),
            const SongTile(),
            const SongTile(),
            const SongTile(),
            const SongTile(),
            const SongTile(),
            const SongTile(),
            const SongTile(),
            const SongTile(),
          ],
        ),
      );
    }

    Widget content() {
      return Column(
        children: [
          header(),
          listOfSong(),
        ],
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(child: content()),
    );
  }
}
