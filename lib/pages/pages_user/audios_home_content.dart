import 'package:flutter/material.dart';
import 'package:music_player/shared/theme.dart';
import 'package:music_player/widgets/audio_tile.dart';

class SongsHomeContent extends StatelessWidget {
  const SongsHomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        padding: EdgeInsets.only(
            right: defaultMargin, left: defaultMargin, top: 24, bottom: 100),
        children: const [
          AudioTile(isHome: true),
          AudioTile(isHome: true),
          AudioTile(isHome: true),
          AudioTile(isHome: true),
          AudioTile(isHome: true),
          AudioTile(isHome: true),
          AudioTile(isHome: true),
        ],
      ),
    );
  }
}
