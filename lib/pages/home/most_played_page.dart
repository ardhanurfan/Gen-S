import 'package:flutter/material.dart';
import 'package:music_player/models/audio_model.dart';
import 'package:music_player/shared/theme.dart';

import '../../widgets/audio_tile.dart';

class MostPlayedPage extends StatelessWidget {
  const MostPlayedPage({super.key, required this.historyMosts});

  final List<AudioModel> historyMosts;

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return SliverPadding(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin, vertical: 24),
        sliver: SliverAppBar(
          stretch: true,
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
                  color: primaryUserColor,
                ),
              ),
              Text(
                "Most Played",
                style: primaryUserColorText.copyWith(
                    fontWeight: bold, fontSize: 24, letterSpacing: 1.3),
              ),
            ],
          ),
          backgroundColor: backgroundUserColor,
          floating: true,
          snap: true,
        ),
      );
    }

    Widget listOfSong() {
      return ListView(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        children: historyMosts
            .map((audio) => AudioTile(
                  audio: audio,
                  playlist: historyMosts,
                  isMostPlayed: true,
                  isHistory: true,
                ))
            .toList(),
      );
    }

    return Scaffold(
      backgroundColor: backgroundUserColor,
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
