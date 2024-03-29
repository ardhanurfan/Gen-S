import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:music_player/models/audio_model.dart';
import 'package:music_player/providers/audio_player_provider.dart';
import 'package:music_player/providers/audio_provider.dart';
import 'package:music_player/providers/user_provider.dart';
import 'package:music_player/shared/theme.dart';
import 'package:music_player/widgets/default_image.dart';
import 'package:music_player/widgets/play_button.dart';
import 'package:provider/provider.dart';

class PlayingTile extends StatelessWidget {
  const PlayingTile({super.key});

  @override
  Widget build(BuildContext context) {
    AudioPlayerProvider audioPlayerProvider =
        Provider.of<AudioPlayerProvider>(context);
    AudioProvider audioProvider = Provider.of<AudioProvider>(context);
    UserProvider userProvider = Provider.of<UserProvider>(context);

    return StreamBuilder<SequenceState?>(
        stream: audioPlayerProvider.audioPlayer.sequenceStateStream,
        builder: (context, snapshot) {
          final state = snapshot.data;
          if (state?.sequence.isEmpty ?? true) {
            return const SizedBox();
          }
          MediaItem audioJson = state!.currentSource!.tag;
          AudioModel audio = AudioModel.fromJson(audioJson.extras!);
          if (audioProvider.currAudio != null &&
              audio.id == audioProvider.currAudio!.id) {
            audio = audioProvider.currAudio!;
          }
          return GestureDetector(
            onTap: () => Navigator.pushNamed(context, '/player'),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 12),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: userProvider.user?.role == "USER" ||
                            userProvider.user == null
                        ? 0
                        : 5,
                    blurRadius: userProvider.user?.role == "USER" ||
                            userProvider.user == null
                        ? 0
                        : 7, // changes position of shadow
                  ),
                ],
                color: userProvider.user?.role == "USER" ||
                        userProvider.user == null
                    ? const Color(0xFF464343)
                    : const Color(0xffFFFFFF),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        audio.images.isNotEmpty
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: CachedNetworkImage(
                                  imageUrl: audio.images[0].url,
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : const DefaultImage(
                                type: ImageType.audio, size: 60),
                        const SizedBox(width: 24),
                        Expanded(
                          child: Text(
                            audio.title,
                            style: (userProvider.user?.role == "USER" ||
                                        userProvider.user == null
                                    ? primaryUserColorText
                                    : primaryAdminColorText)
                                .copyWith(
                              fontSize: 16,
                              fontWeight: bold,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const PlayButton(size: 36),
                ],
              ),
            ),
          );
        });
  }
}
