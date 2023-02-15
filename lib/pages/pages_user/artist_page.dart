import 'package:flutter/material.dart';

import '../../shared/theme.dart';

class ArtistPage extends StatelessWidget {
  const ArtistPage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin, vertical: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back,
                  color: primaryColor,
                )),
            Text(
              "Artist",
              style: primaryColorText.copyWith(
                  fontWeight: bold, fontSize: 24, letterSpacing: 1.3),
            )
          ],
        ),
      );
    }

    Widget sortAndFilter() {
      return Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "12 Artists",
                  style:
                      primaryColorText.copyWith(fontSize: 16, fontWeight: bold),
                ),
                Container(
                  width: 15,
                  height: 17,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/sort_icon.png"),
                          fit: BoxFit.cover)),
                )
              ],
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 14),
              height: 1,
              decoration: BoxDecoration(color: primaryColor),
            )
          ],
        ),
      );
    }

    Widget artistTile() {
      return Container(
        margin: const EdgeInsets.only(bottom: 24),
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.only(right: 32),
              height: 84,
              width: 84,
              decoration: BoxDecoration(
                  image: const DecorationImage(
                      image: AssetImage("assets/artist_img.png"),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(180)),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Ariana Grande",
                    overflow: TextOverflow.ellipsis,
                    style: primaryColorText.copyWith(
                        fontSize: 14, fontWeight: bold),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    "1 Album | 12 songs",
                    overflow: TextOverflow.clip,
                    style: primaryColorText.copyWith(
                        fontSize: 12, fontWeight: light),
                  )
                ],
              ),
            )
          ],
        ),
      );
    }

    Widget listOfArtist() {
      return Expanded(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 24),
          children: [
            artistTile(),
            artistTile(),
            artistTile(),
            artistTile(),
            artistTile(),
            artistTile(),
            artistTile(),
          ],
        ),
      );
    }

    Widget content() {
      return Column(
        children: [
          header(),
          sortAndFilter(),
          listOfArtist(),
        ],
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(child: content()),
    );
  }
}
