import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:music_player/models/audio_model.dart';
import 'package:music_player/providers/playlist_provider.dart';
import 'package:provider/provider.dart';

import '../providers/audio_player_provider.dart';
import '../shared/theme.dart';

class AddAudioPlaylistTile extends StatelessWidget {
  final AudioModel audio;
  final bool isAdded;
  final int playlistId;

  const AddAudioPlaylistTile({
    required this.audio,
    required this.isAdded,
    required this.playlistId,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AudioPlayerProvider audioPlayerProvider =
        Provider.of<AudioPlayerProvider>(context);
    PlaylistProvider playlistProvider = Provider.of<PlaylistProvider>(context);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      color: backgroundUserColor,
      child: Row(
        children: [
          Container(
            height: 60,
            margin: const EdgeInsets.only(right: 24),
            width: 60,
            child: audio.images.isEmpty
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      "assets/bg_song_example.png",
                      fit: BoxFit.cover,
                    ),
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: CachedNetworkImage(
                      imageUrl: audio.images[0].url,
                      fit: BoxFit.cover,
                    ),
                  ),
          ),
          Expanded(
            child: Text(
              audio.title,
              overflow: TextOverflow.ellipsis,
              style: primaryUserColorText.copyWith(
                fontSize: 16,
                fontWeight: bold,
              ),
            ),
          ),
          Row(
            children: [
              isAdded
                  ? GestureDetector(
                      onTap: () async {
                        audioPlayerProvider.deleteAudio(audioId: audio.id);
                        if (await playlistProvider.deleteAudio(
                          audio: audio,
                          playlistId: playlistId,
                        )) {
                          ScaffoldMessenger.of(context).removeCurrentSnackBar();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: successColor,
                              content: const Text(
                                'Delete audio from playlist successfuly',
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).removeCurrentSnackBar();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: alertColor,
                              content: Text(
                                playlistProvider.errorMessage,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                        }
                      },
                      child: Icon(
                        Icons.check_circle,
                        color: secondaryColor,
                        size: 28,
                      ),
                    )
                  : GestureDetector(
                      onTap: () async {
                        if (await playlistProvider.addAudio(
                          audio: audio,
                          playlistId: playlistId,
                        )) {
                          audioPlayerProvider.addAudio(
                              audio: audio, isPlaylist: true);
                          ScaffoldMessenger.of(context).removeCurrentSnackBar();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: successColor,
                              content: const Text(
                                'Add audio to playlist successfuly',
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).removeCurrentSnackBar();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: alertColor,
                              content: Text(
                                playlistProvider.errorMessage,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                        }
                      },
                      child: Icon(
                        Icons.add_circle_outline,
                        color: primaryUserColor,
                        size: 28,
                      ),
                    ),
            ],
          )
        ],
      ),
    );
  }
}
