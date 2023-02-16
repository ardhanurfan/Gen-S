import 'package:flutter/material.dart';

import '../../shared/theme.dart';

class ArtistPage extends StatelessWidget {
  const ArtistPage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return SliverPadding(
        padding:
            EdgeInsets.only(right: defaultMargin, left: defaultMargin, top: 24),
        sliver: SliverAppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          titleSpacing: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back,
                  color: primaryColor,
                ),
              ),
              Text(
                "Artist",
                style: primaryColorText.copyWith(
                    fontWeight: bold, fontSize: 24, letterSpacing: 1.3),
              ),
            ],
          ),
          backgroundColor: backgroundColor,
          floating: true,
          snap: true,
        ),
      );
    }

    Widget sortAndFilter() {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin, vertical: 16),
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
                GestureDetector(
                  onTap: () {},
                  child: RotatedBox(
                    quarterTurns: 1,
                    child: Icon(
                      Icons.compare_arrows,
                      size: 28,
                      color: primaryColor,
                    ),
                  ),
                ),
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
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
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
          sortAndFilter(),
          listOfArtist(),
        ],
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              header(),
            ];
          },
          body: content(),
        ),
      ),
    );
  }
}
