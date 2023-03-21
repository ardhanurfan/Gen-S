import 'package:flutter/material.dart';
import 'package:music_player/models/audio_model.dart';
import 'package:music_player/shared/theme.dart';
import 'package:music_player/widgets/audio_tile.dart';
import 'package:provider/provider.dart';

import '../../providers/audio_player_provider.dart';
import '../../widgets/playing_tile.dart';

class RecentlyPlayedPage extends StatelessWidget {
  const RecentlyPlayedPage({super.key, required this.historyRecents});

  final List<AudioModel> historyRecents;

  @override
  Widget build(BuildContext context) {
    AudioPlayerProvider audioPlayerProvider =
        Provider.of<AudioPlayerProvider>(context);

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
      return ListView(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        children: historyRecents
            .map(
              (audio) => GestureDetector(
                onTap: () {
                  audioPlayerProvider.setPlay(
                    historyRecents,
                    historyRecents.indexOf(audio),
                  );
                },
                child: AudioTile(
                  audio: audio,
                  isHistory: true,
                  playlist: historyRecents,
                ),
              ),
            )
            .toList(),
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            NestedScrollView(
              floatHeaderSlivers: true,
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  header(),
                ];
              },
              body: listOfSong(),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              child: const PlayingTile(),
            ),
          ],
        ),
      ),
    );
  }
}
