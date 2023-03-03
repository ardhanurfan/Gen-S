import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../shared/theme.dart';

class AudioTile extends StatelessWidget {
  final bool isHome;
  final bool isMostPlayed;
  final bool isSearch;
  final String title;
  final String coverUrl;

  const AudioTile({
    this.isHome = false,
    this.isMostPlayed = false,
    this.isSearch = false,
    required this.title,
    this.coverUrl = '',
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
            child: coverUrl.isEmpty
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      "assets/bg_song_example.png",
                      fit: BoxFit.cover,
                    ),
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: CachedNetworkImage(
                      imageUrl: coverUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  style:
                      primaryColorText.copyWith(fontSize: 16, fontWeight: bold),
                ),
                // const SizedBox(
                //   height: 8,
                // ),
                // Text(
                //   "Bruno Mars",
                //   overflow: TextOverflow.ellipsis,
                //   style: primaryColorText.copyWith(
                //       fontSize: 16, fontWeight: regular),
                // ),
              ],
            ),
          ),
          Row(
            children: [
              Visibility(
                visible: isSearch ? false : true,
                child: GestureDetector(
                  onTap: () {},
                  child: Icon(
                    Icons.play_circle,
                    color: primaryColor,
                  ),
                ),
              ),
              const SizedBox(width: 20),
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
