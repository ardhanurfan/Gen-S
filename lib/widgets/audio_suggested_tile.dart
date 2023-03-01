import 'package:flutter/material.dart';

import '../shared/theme.dart';

class AudioSuggestedTile extends StatelessWidget {
  const AudioSuggestedTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 24),
      width: 120,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              'assets/bg_song_example.png',
              width: 120,
              height: 120,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Locked Out Heaven',
            style: primaryColorText.copyWith(fontSize: 12),
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            'Bruno Mars',
            style: primaryColorText.copyWith(fontSize: 12),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
