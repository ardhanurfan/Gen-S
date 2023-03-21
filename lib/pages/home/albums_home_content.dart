import 'package:flutter/material.dart';
import 'package:music_player/providers/user_provider.dart';
import 'package:provider/provider.dart';

import '../../../shared/theme.dart';

class AlbumsHomeContent extends StatelessWidget {
  const AlbumsHomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
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
            style: userProvider.user.role == "USER"
                ? primaryUserColorText.copyWith(fontSize: 16, fontWeight: bold)
                : primaryAdminColorText.copyWith(
                    fontSize: 16, fontWeight: bold),
          ),
          Text(
            "Taylor Swift",
            style: userProvider.user.role == "USER"
                ? primaryUserColorText.copyWith(
                    fontSize: 12,
                  )
                : primaryAdminColorText.copyWith(
                    fontSize: 12,
                  ),
          )
        ],
      );
    }

    return Expanded(
      child: GridView(
        padding: const EdgeInsets.only(top: 24, bottom: 100),
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
