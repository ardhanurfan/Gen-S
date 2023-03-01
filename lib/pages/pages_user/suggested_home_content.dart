import 'package:flutter/material.dart';

import '../../shared/theme.dart';
import '../../widgets/audio_suggested_tile.dart';
import '../../widgets/section_title.dart';

class SuggestedHomeContent extends StatelessWidget {
  const SuggestedHomeContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        padding: const EdgeInsets.only(top: 24, bottom: 100),
        children: [
          SectionTitle(
            onTap: () {
              Navigator.pushNamed(context, '/recently-played');
            },
            title: 'Recently Played',
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              margin: EdgeInsets.only(
                  left: defaultMargin, right: defaultMargin - 24),
              child: Row(
                children: const [
                  AudioSuggestedTile(),
                  AudioSuggestedTile(),
                  AudioSuggestedTile(),
                  AudioSuggestedTile(),
                  AudioSuggestedTile(),
                ],
              ),
            ),
          ),
          SectionTitle(
            onTap: () {
              Navigator.pushNamed(context, '/most-played');
            },
            marginTop: 48,
            title: 'Most Played',
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              margin: EdgeInsets.only(
                  left: defaultMargin, right: defaultMargin - 24),
              child: Row(
                children: const [
                  AudioSuggestedTile(),
                  AudioSuggestedTile(),
                  AudioSuggestedTile(),
                  AudioSuggestedTile(),
                  AudioSuggestedTile(),
                ],
              ),
            ),
          ),
          const SizedBox(height: 48),
        ],
      ),
    );
  }
}
