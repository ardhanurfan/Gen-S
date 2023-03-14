import 'package:flutter/material.dart';
import 'package:music_player/providers/audio_player_provider.dart';
import 'package:music_player/providers/audio_provider.dart';
import 'package:music_player/shared/theme.dart';
import 'package:music_player/widgets/audio_tile.dart';
import 'package:provider/provider.dart';

class SongsHomeContent extends StatelessWidget {
  const SongsHomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    AudioProvider audioProvider = Provider.of<AudioProvider>(context);
    AudioPlayerProvider audioPlayerProvider =
        Provider.of<AudioPlayerProvider>(context);

    return Expanded(
      child: ListView(
        padding: EdgeInsets.only(
            right: defaultMargin, left: defaultMargin, top: 24, bottom: 100),
        children: audioProvider.audios
            .map(
              (audio) => GestureDetector(
                onTap: () async {
                  audioPlayerProvider.setPlay(
                    audioProvider.audios,
                    audioProvider.audios.indexOf(audio),
                  );
                },
                child: AudioTile(
                  audio: audio,
                  isPlaying: audioPlayerProvider.currentAudio.id == audio.id,
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
