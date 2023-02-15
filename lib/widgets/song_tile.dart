import 'package:flutter/material.dart';

import '../shared/theme.dart';

class SongTile extends StatelessWidget {
  final bool isHome;
  final bool isMostPlayed;
  const SongTile({
    this.isHome = false,
    this.isMostPlayed = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      child: Row(
        children: [
          Visibility(
            visible: isMostPlayed,
            child: Container(
              margin: const EdgeInsets.only(right: 20),
              width: 30,
              child: Text("20",
                  style: primaryColorText.copyWith(
                      fontWeight: bold,
                      fontSize: 20,
                      foreground: Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 0.1
                        ..color = primaryColor)),
            ),
          ),
          Container(
            height: 60,
            margin: const EdgeInsets.only(right: 24),
            width: 60,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/bg_song_example.png"),
                    fit: BoxFit.fill)),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Locked Out of Heaven",
                  overflow: TextOverflow.ellipsis,
                  style:
                      primaryColorText.copyWith(fontSize: 16, fontWeight: bold),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  "Bruno Mars",
                  overflow: TextOverflow.ellipsis,
                  style: primaryColorText.copyWith(
                      fontSize: 16, fontWeight: regular),
                ),
              ],
            ),
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {},
                child: Icon(
                  Icons.play_circle,
                  color: primaryColor,
                ),
              ),
              Visibility(
                visible: isHome,
                child: GestureDetector(
                  onTap: () {},
                  child: Icon(
                    Icons.more_vert,
                    color: primaryColor,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
