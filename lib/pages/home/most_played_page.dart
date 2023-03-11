import 'package:flutter/material.dart';
import 'package:music_player/models/audio_model.dart';
import 'package:music_player/shared/theme.dart';
import 'package:provider/provider.dart';

import '../../providers/audio_player_provider.dart';
import '../../widgets/audio_tile.dart';

class MostPlayedPage extends StatelessWidget {
  const MostPlayedPage({super.key, required this.historyMosts});

  final List<AudioModel> historyMosts;

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
                "Most Played",
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
        children: historyMosts
            .map((audio) => GestureDetector(
                  onTap: () {
                    audioPlayerProvider.setPlay(
                      historyMosts,
                      historyMosts.indexOf(audio),
                    );
                  },
                  child: AudioTile(
                    audio: audio,
                    sequence: historyMosts.indexOf(audio) + 1,
                    isMostPlayed: true,
                    isPlaying: audioPlayerProvider.currentAudioId == audio.id,
                  ),
                ))
            .toList(),
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
