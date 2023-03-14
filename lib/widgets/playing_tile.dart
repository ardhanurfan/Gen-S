import 'package:flutter/material.dart';
import 'package:music_player/shared/theme.dart';

class PlayingTile extends StatelessWidget {
  const PlayingTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: const Color(0xFF464343),
      ),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                ClipRRect(
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
                  'Judul Lagu',
                  style: primaryColorText.copyWith(
                    fontSize: 16,
                    fontWeight: bold,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.play_circle,
            color: primaryColor,
            size: 36,
          ),
        ],
      ),
    );
  }
}
