import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:music_player/pages/audio_player_page.dart';

import '../shared/theme.dart';

class AudioSuggestedTile extends StatelessWidget {
  const AudioSuggestedTile({
    Key? key,
    required this.title,
    this.coverUrl = '',
  }) : super(key: key);

  final String title;
  final String coverUrl;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const AudioPlayerPage(),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(right: 24),
        width: 120,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: coverUrl.isEmpty
                  ? Image.asset(
                      'assets/bg_song_example.png',
                      width: 120,
                      height: 120,
                      fit: BoxFit.cover,
                    )
                  : CachedNetworkImage(
                      imageUrl: coverUrl,
                      width: 120,
                      height: 120,
                      fit: BoxFit.cover,
                    ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: primaryColorText.copyWith(fontSize: 12),
              overflow: TextOverflow.ellipsis,
            ),
            // Text(
            //   'Bruno Mars',
            //   style: primaryColorText.copyWith(fontSize: 12),
            //   overflow: TextOverflow.ellipsis,
            // ),
          ],
        ),
      ),
    );
  }
}
