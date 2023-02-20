import 'package:flutter/material.dart';
import 'package:music_player/shared/theme.dart';

class PlaylistPage extends StatelessWidget {
  const PlaylistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: const Center(
        child: Text('Playlist Page'),
      ),
    );
  }
}