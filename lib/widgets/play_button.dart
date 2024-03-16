import 'package:flutter/material.dart';

import 'package:just_audio/just_audio.dart';
import 'package:music_player/providers/audio_player_provider.dart';
import 'package:music_player/providers/audio_provider.dart';
import 'package:music_player/providers/user_provider.dart';
import 'package:music_player/shared/theme.dart';
import 'package:provider/provider.dart';

class PlayButton extends StatelessWidget {
  const PlayButton({super.key, required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    AudioPlayerProvider audioPlayerProvider =
        Provider.of<AudioPlayerProvider>(context);
    AudioProvider audioProvider = Provider.of<AudioProvider>(context);
    UserProvider userProvider = Provider.of<UserProvider>(context);
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
            color:
                userProvider.user?.role == "USER" || userProvider.user == null
                    ? primaryUserColor
                    : primaryAdminColor,
            icon: const Icon(Icons.play_circle),
          );
        } else if (processingState != ProcessingState.completed) {
          return IconButton(
            onPressed: audioPlayerProvider.audioPlayer.pause,
            iconSize: size,
            color:
                userProvider.user?.role == "USER" || userProvider.user == null
                    ? primaryUserColor
                    : primaryAdminColor,
            icon: const Icon(Icons.pause_circle),
          );
        } else if (processingState == ProcessingState.completed) {
          if (audioProvider.currAudio!.id ==
              audioPlayerProvider.currentPlaylist.last.id) {
            audioPlayerProvider.audioPlayer.seek(const Duration(seconds: 0),
                index: audioPlayerProvider.currentPlaylist.length - 1);
            audioPlayerProvider.audioPlayer.pause();
          }
          return IconButton(
            onPressed: audioPlayerProvider.audioPlayer.play,
            iconSize: size,
            color:
                userProvider.user?.role == "USER" || userProvider.user == null
                    ? primaryUserColor
                    : primaryAdminColor,
            icon: const Icon(Icons.play_circle),
          );
        }
        return IconButton(
          onPressed: audioPlayerProvider.audioPlayer.play,
          iconSize: size,
          color: userProvider.user?.role == "USER" || userProvider.user == null
              ? primaryUserColor
              : primaryAdminColor,
          icon: const Icon(Icons.play_circle),
        );
      },
    );
  }
}
