import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
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

  @override
  Widget build(BuildContext context) {
    AudioPlayerProvider audioPlayerProvider =
        Provider.of<AudioPlayerProvider>(context);

    Stream<PositionDataModel> positionDataStream =
        Rx.combineLatest3<Duration, Duration, Duration?, PositionDataModel>(
      audioPlayerProvider.audioPlayer.positionStream,
      audioPlayerProvider.audioPlayer.bufferedPositionStream,
      audioPlayerProvider.audioPlayer.durationStream,
      (position, bufferedPosition, duration) => PositionDataModel(
          position, bufferedPosition, duration ?? Duration.zero),
    );

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
            StreamBuilder<SequenceState?>(
              stream: audioPlayerProvider.audioPlayer.sequenceStateStream,
              builder: (context, snapshot) {
                final state = snapshot.data;
                if (state?.sequence.isEmpty ?? true) {
                  return const SizedBox();
                }
                AudioModel audio = state!.currentSource!.tag;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    audio.images.isEmpty
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(32),
                            child: Image.asset(
                              "assets/audio_page.png",
                              height: 280,
                              width: 280,
                              fit: BoxFit.cover,
                            ),
                          )
                        : CarouselSlider(
                            items: audio.images
                                .map(
                                  (image) => ClipRRect(
                                    borderRadius: BorderRadius.circular(32),
                                    child: CachedNetworkImage(
                                      imageUrl: image.url,
                                      width: 280,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )
                                .toList(),
                            options: CarouselOptions(
                              autoPlay: audio.images.length > 1,
                              enableInfiniteScroll: audio.images.length > 1,
                              viewportFraction: 1,
                              enlargeCenterPage: false,
                              height: 280,
                              autoPlayAnimationDuration:
                                  const Duration(milliseconds: 2000),
                              autoPlayInterval: const Duration(seconds: 10),
                            ),
                          ),
                    const SizedBox(
                      height: 64,
                    ),
                    Text(
                      audio.title,
                      style: primaryColorText.copyWith(
                        fontSize: 16,
                        fontWeight: bold,
                      ),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(
              height: 24,
            ),
            StreamBuilder<PositionDataModel>(
                stream: positionDataStream,
                builder: (context, snapshot) {
                  final positionData = snapshot.data;
                  return Container(
                    margin: const EdgeInsets.only(top: 5, bottom: 50),
                    width: double.infinity,
                    child: ProgressBar(
                      timeLabelLocation: TimeLabelLocation.above,
                      timeLabelPadding: 8,
                      timeLabelTextStyle:
                          primaryColorText.copyWith(fontSize: 12),
                      barHeight: 8,
                      baseBarColor: backgroundProgressIndicatorColor,
                      bufferedBarColor: Colors.transparent,
                      progressBarColor: progressIndicatorColor,
                      thumbRadius: 0,
                      thumbGlowRadius: 0,
                      progress: positionData?.position ?? Duration.zero,
                      buffered: positionData?.bufferedPosition ?? Duration.zero,
                      total: positionData?.duration ?? Duration.zero,
                      onSeek: audioPlayerProvider.audioPlayer.seek,
                    ),
                  );
                }),
            const AudioController(),
          ],
        ),
      );
    }

    Widget content() {
      return ListView(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin, vertical: 32),
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
        StreamBuilder<bool>(
            stream: audioPlayerProvider.audioPlayer.shuffleModeEnabledStream,
            builder: (context, snapshot) {
              return GestureDetector(
                onTap: () async {
                  final enable = !(snapshot.data ?? false);
                  if (enable) {
                    await audioPlayerProvider.audioPlayer.shuffle();
                  }
                  await audioPlayerProvider.audioPlayer
                      .setShuffleModeEnabled(enable);
                },
                child: Icon(
                  Icons.shuffle,
                  color: snapshot.data ?? false ? secondaryColor : primaryColor,
                  size: 28,
                ),
              );
            }),
        GestureDetector(
          onTap: () {
            audioPlayerProvider.audioPlayer.seekToPrevious();
          },
          child: Icon(
            Icons.fast_rewind_outlined,
            color: primaryColor,
            size: 34,
          ),
        ),
        const PlayButton(size: 54),
        GestureDetector(
          onTap: () {
            audioPlayerProvider.audioPlayer.seekToNext();
          },
          child: Icon(
            Icons.fast_forward_outlined,
            color: primaryColor,
            size: 34,
          ),
        ),
        StreamBuilder<LoopMode>(
            stream: audioPlayerProvider.audioPlayer.loopModeStream,
            builder: (context, snapshot) {
              return GestureDetector(
                onTap: () async {
                  final current = snapshot.data;
                  if (current == LoopMode.all) {
                    await audioPlayerProvider.audioPlayer
                        .setLoopMode(LoopMode.one);
                  }
                  if (current == LoopMode.one) {
                    await audioPlayerProvider.audioPlayer
                        .setLoopMode(LoopMode.off);
                  }
                  if (current == LoopMode.off) {
                    await audioPlayerProvider.audioPlayer
                        .setLoopMode(LoopMode.all);
                  }
                },
                child: Icon(
                  Icons.replay,
                  color: primaryColor,
                  size: 28,
                ),
              );
            }),
      ],
    );
  }
}
