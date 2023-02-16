import 'package:flutter/material.dart';

import '../../shared/theme.dart';

class AlbumsPage extends StatelessWidget {
  const AlbumsPage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget albumGrid() {
      return Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              "assets/album_img.png",
              width: 160,
              height: 160,
            ),
          ),
          Text(
            "1989",
            style: primaryColorText.copyWith(fontSize: 16, fontWeight: bold),
          ),
          Text(
            "Taylor Swift",
            style: primaryColorText.copyWith(fontSize: 12),
          )
        ],
      );
    }

    return Expanded(
      child: GridView(
        padding: const EdgeInsets.only(top: 24, bottom: 120),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 1 / 1.2),
        children: [
          albumGrid(),
          albumGrid(),
          albumGrid(),
          albumGrid(),
          albumGrid(),
          albumGrid(),
          albumGrid(),
          albumGrid()
        ],
      ),
    );
  }
}
