import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_player/models/audio_model.dart';
import 'package:music_player/models/position_data_model.dart';
import 'package:music_player/providers/audio_player_provider.dart';
import 'package:music_player/shared/theme.dart';
import 'package:music_player/widgets/play_button.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

class AudioPlayerPage extends StatelessWidget {
  const AudioPlayerPage({super.key});

  // Stream<PositionDataModel> get _positionDataStream =>
  //     Rx.combineLatest3<Duration, Duration, Duration?, PositionDataModel>(
  //       _audioPlayer.positionStream,
  //       _audioPlayer.bufferedPositionStream,
  //       _audioPlayer.durationStream,
  //       (position, bufferedPosition, duration) => PositionDataModel(
  //           position, bufferedPosition, duration ?? Duration.zero),
  //     );

  @override
  Widget build(BuildContext context) {
    AudioPlayerProvider audioPlayerProvider =
        Provider.of<AudioPlayerProvider>(context);

    AudioModel currentAudio = audioPlayerProvider.currentAudio;

    Widget header() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(
              Icons.keyboard_arrow_down_rounded,
              color: primaryColor,
            ),
          ),
          Text(
            "playing from playlist",
            textAlign: TextAlign.center,
            style: primaryColorText.copyWith(fontSize: 12),
          ),
          GestureDetector(
            child: Icon(
              Icons.more_vert,
              color: primaryColor,
            ),
          )
        ],
      );
    }

    Widget music() {
      return Container(
        margin: const EdgeInsets.only(top: 16),
        child: Column(
          children: [
            Text(
              "Favourite of Maliq & D'Essentials",
              style: primaryColorText.copyWith(fontSize: 16, fontWeight: bold),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(
              height: 55,
            ),
            currentAudio.images.isEmpty
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(32),
                    child: Image.asset(
                      "assets/audio_page.png",
                      height: 280,
                      width: 280,
                    ),
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(32),
                    child: CachedNetworkImage(
                      imageUrl: currentAudio.images[0].url,
                      height: 280,
                      width: 280,
                    ),
                  ),
            const SizedBox(
              height: 64,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    currentAudio.title,
                    style: primaryColorText.copyWith(
                        fontSize: 16, fontWeight: bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Icon(
                  Icons.favorite,
                  color: primaryColor,
                )
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "2:10",
                  style: primaryColorText.copyWith(fontSize: 12),
                ),
                Text("4:58", style: primaryColorText.copyWith(fontSize: 12))
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 5, bottom: 50),
              width: double.infinity,
              height: 8,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: LinearProgressIndicator(
                  backgroundColor: backgroundProgressIndicatorColor,
                  value: 2.1 / 4.58,
                  color: progressIndicatorColor,
                  minHeight: 8,
                ),
              ),
            ),
            const AudioController(),
          ],
        ),
      );
    }

    Widget content() {
      return ListView(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin, vertical: 60),
        children: [
          header(),
          music(),
        ],
      );
    }

    return Scaffold(
        backgroundColor: backgroundColor, body: SafeArea(child: content()));
  }
}

class AudioController extends StatelessWidget {
  const AudioController({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AudioPlayerProvider audioPlayerProvider =
        Provider.of<AudioPlayerProvider>(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {},
          child: Icon(
            Icons.shuffle,
            color: primaryColor,
            size: 28,
          ),
        ),
        GestureDetector(
          onTap: () async {
            await audioPlayerProvider.audioPlayer.seekToPrevious();
            audioPlayerProvider.updateAudio();
          },
          child: Icon(
            Icons.fast_rewind_outlined,
            color: primaryColor,
            size: 34,
          ),
        ),
        const PlayButton(size: 34),
        GestureDetector(
          onTap: () async {
            await audioPlayerProvider.audioPlayer.seekToNext();
            audioPlayerProvider.updateAudio();
          },
          child: Icon(
            Icons.fast_forward_outlined,
            color: primaryColor,
            size: 34,
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: Icon(
            Icons.replay,
            color: primaryColor,
            size: 28,
          ),
        ),
      ],
    );
  }
}
