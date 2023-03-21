import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_player/models/audio_model.dart';
import 'package:music_player/providers/audio_player_provider.dart';
import 'package:music_player/shared/theme.dart';
import 'package:music_player/widgets/play_button.dart';
import 'package:provider/provider.dart';

class PlayingTile extends StatelessWidget {
  const PlayingTile({super.key});

  @override
  Widget build(BuildContext context) {
    AudioPlayerProvider audioPlayerProvider =
        Provider.of<AudioPlayerProvider>(context);

    return StreamBuilder<SequenceState?>(
        stream: audioPlayerProvider.audioPlayer.sequenceStateStream,
        builder: (context, snapshot) {
          final state = snapshot.data;
          if (state?.sequence.isEmpty ?? true) {
            return const SizedBox();
          }
          AudioModel audio = state!.currentSource!.tag;
          return GestureDetector(
            onTap: () => Navigator.pushNamed(context, '/player'),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 12),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: const Color(0xFF464343),
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
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  'assets/ex_gallery1.png',
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.cover,
                                ),
                              ),
                        const SizedBox(width: 24),
                        Text(
                          audio.title,
                          style: primaryUserColorText.copyWith(
                            fontSize: 16,
                            fontWeight: bold,
                          ),
                          overflow: TextOverflow.ellipsis,
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
