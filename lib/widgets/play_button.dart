import 'package:flutter/material.dart';

import 'package:just_audio/just_audio.dart';
import 'package:music_player/providers/audio_player_provider.dart';
import 'package:music_player/shared/theme.dart';
import 'package:provider/provider.dart';

class PlayButton extends StatelessWidget {
  const PlayButton({super.key, required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    AudioPlayerProvider audioPlayerProvider =
        Provider.of<AudioPlayerProvider>(context);
    return StreamBuilder<PlayerState>(
      stream: audioPlayerProvider.audioPlayer.playerStateStream,
      builder: (context, snapshot) {
        final playerState = snapshot.data;
        final processingState = playerState?.processingState;
        final playing = playerState?.playing;
        if (!(playing ?? false)) {
          return IconButton(
            onPressed: audioPlayerProvider.audioPlayer.play,
            iconSize: size,
            color: primaryUserColor,
            icon: const Icon(Icons.play_circle),
          );
        } else if (processingState != ProcessingState.completed) {
          return IconButton(
            onPressed: audioPlayerProvider.audioPlayer.pause,
            iconSize: size,
            color: primaryUserColor,
            icon: const Icon(Icons.pause_circle),
          );
        }
        return IconButton(
          onPressed: audioPlayerProvider.audioPlayer.play,
          iconSize: size,
          color: primaryUserColor,
          icon: const Icon(Icons.play_circle),
        );
      },
    );
  }
}
