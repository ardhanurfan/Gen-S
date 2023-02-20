import 'package:flutter/material.dart';
import 'package:music_player/shared/theme.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: const Center(
        child: Text('Search Page'),
      ),
    );
  }
}
