import 'package:flutter/material.dart';
import 'package:music_player/shared/theme.dart';
import 'package:music_player/widgets/song_tile.dart';

class SongsHomeContent extends StatelessWidget {
  const SongsHomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        padding: EdgeInsets.only(
            right: defaultMargin, left: defaultMargin, top: 24, bottom: 120),
        children: const [
          SongTile(isHome: true),
          SongTile(isHome: true),
          SongTile(isHome: true),
          SongTile(isHome: true),
          SongTile(isHome: true),
          SongTile(isHome: true),
          SongTile(isHome: true),
        ],
      ),
    );
  }
}
