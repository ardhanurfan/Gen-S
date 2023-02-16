import 'package:flutter/material.dart';
import 'package:music_player/shared/theme.dart';
import 'package:music_player/widgets/song_tile.dart';

class RecentlyPlayedPage extends StatelessWidget {
  const RecentlyPlayedPage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return SliverPadding(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin, vertical: 24),
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
                "Recently Played",
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

    Widget listOfSong() {
      return Expanded(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          children: const [
            SongTile(),
            SongTile(),
            SongTile(),
            SongTile(),
            SongTile(),
            SongTile(),
            SongTile(),
            SongTile(),
            SongTile(),
            SongTile(),
            SongTile(),
          ],
        ),
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
          body: listOfSong(),
        ),
      ),
    );
  }
}
