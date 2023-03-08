import 'package:flutter/material.dart';
import 'package:music_player/pages/home/most_played_page.dart';
import 'package:music_player/pages/home/recently_played_page.dart';
import 'package:music_player/providers/audio_provider.dart';
import 'package:provider/provider.dart';

import '../../shared/theme.dart';
import '../../widgets/audio_suggested_tile.dart';
import '../../widgets/section_title.dart';

class SuggestedHomeContent extends StatelessWidget {
  const SuggestedHomeContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AudioProvider audioProvider = Provider.of<AudioProvider>(context);

    return Expanded(
      child: ListView(
        padding: const EdgeInsets.only(top: 24, bottom: 100),
        children: [
          SectionTitle(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RecentlyPlayedPage(
                    historyRecents: audioProvider.historyRecents,
                  ),
                ),
              );
            },
            title: 'Recently Played',
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              margin: EdgeInsets.only(
                  left: defaultMargin, right: defaultMargin - 24),
              child: Row(
                children: audioProvider.historyRecents
                    .map(
                      (audio) => AudioSuggestedTile(
                        title: audio.title,
                        coverUrl:
                            audio.images.isEmpty ? '' : audio.images[0].url,
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
          SectionTitle(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      MostPlayedPage(historyMosts: audioProvider.historyMosts),
                ),
              );
            },
            marginTop: 36,
            title: 'Most Played',
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              margin: EdgeInsets.only(
                  left: defaultMargin, right: defaultMargin - 24),
              child: Row(
                children: audioProvider.historyMosts
                    .map(
                      (audio) => AudioSuggestedTile(
                        title: audio.title,
                        coverUrl:
                            audio.images.isEmpty ? '' : audio.images[0].url,
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
