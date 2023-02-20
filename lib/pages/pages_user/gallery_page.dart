import 'package:flutter/material.dart';
import 'package:music_player/shared/theme.dart';

class GalleryPage extends StatelessWidget {
  const GalleryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: const Center(
        child: Text('Gallery Page'),
      ),
    );
  }
}
