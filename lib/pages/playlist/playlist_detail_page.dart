import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:music_player/models/playlist_model.dart';
import 'package:music_player/shared/theme.dart';
import 'package:music_player/widgets/audio_tile.dart';
import 'package:provider/provider.dart';

import '../../providers/audio_player_provider.dart';

class PlaylistDetailPage extends StatelessWidget {
  const PlaylistDetailPage({required this.playlist, super.key});

  final PlaylistModel playlist;

  @override
  Widget build(BuildContext context) {
    AudioPlayerProvider audioPlayerProvider =
        Provider.of<AudioPlayerProvider>(context);

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
            playlist.audios.isEmpty
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: Image.asset(
                      "assets/ex_playlist.png",
                      width: 200,
                      height: 200,
                      alignment: Alignment.center,
                    ),
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: CachedNetworkImage(
                      imageUrl: playlist.audios[0].images[0].url,
                      fit: BoxFit.cover,
                      width: 200,
                      height: 200,
                      alignment: Alignment.center,
                    ),
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
              playlist.audios.length.toString(),
              style: primaryColorText.copyWith(fontSize: 12, fontWeight: light),
            )
          ],
        ),
      );
    }

    Widget audioList() {
      return Column(
        children: playlist.audios
            .map(
              (audio) => GestureDetector(
                onTap: () {
                  audioPlayerProvider.setPlay(
                    playlist.audios,
                    playlist.audios.indexOf(audio),
                  );
                },
                child: AudioTile(
                  audio: audio,
                  isPlaying: audioPlayerProvider.currentAudio.id == audio.id,
                ),
              ),
            )
            .toList(),
      );
    }

    Widget content() {
      return ListView(
        padding: EdgeInsets.all(defaultMargin),
        children: [
          header(),
          playlistInfo(),
          audioList(),
        ],
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(child: content()),
    );
  }
}
