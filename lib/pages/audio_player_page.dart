// ignore_for_file: use_build_context_synchronously

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:music_player/models/audio_model.dart';
import 'package:music_player/models/image_model.dart';
import 'package:music_player/models/position_data_model.dart';
import 'package:music_player/providers/ads_provider.dart';
import 'package:music_player/providers/audio_player_provider.dart';
import 'package:music_player/providers/audio_provider.dart';
import 'package:music_player/providers/gallery_provider.dart';
import 'package:music_player/providers/images_provider.dart';
import 'package:music_player/providers/playlist_provider.dart';
import 'package:music_player/providers/user_provider.dart';
import 'package:music_player/shared/theme.dart';
import 'package:music_player/widgets/ads_banner_player.dart';
import 'package:music_player/widgets/default_image.dart';
import 'package:music_player/widgets/delete_popup.dart';
import 'package:music_player/widgets/image_popup.dart';
import 'package:music_player/widgets/play_button.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AudioPlayerPage extends StatelessWidget {
  const AudioPlayerPage({super.key});

  @override
  Widget build(BuildContext context) {
    AudioPlayerProvider audioPlayerProvider =
        Provider.of<AudioPlayerProvider>(context);
    AudioProvider audioProvider = Provider.of<AudioProvider>(context);
    AdsProvider adsProvider = Provider.of<AdsProvider>(context);
    PlaylistProvider playlistProvider = Provider.of<PlaylistProvider>(context);
    UserProvider userProvider = Provider.of<UserProvider>(context);
    ImagesProvider imagesProvider = Provider.of<ImagesProvider>(context);
    GalleryProvider galleryProvider = Provider.of<GalleryProvider>(context);

    Stream<PositionDataModel> positionDataStream =
        Rx.combineLatest3<Duration, Duration, Duration?, PositionDataModel>(
      audioPlayerProvider.audioPlayer.positionStream,
      audioPlayerProvider.audioPlayer.bufferedPositionStream,
      audioPlayerProvider.audioPlayer.durationStream,
      (position, bufferedPosition, duration) => PositionDataModel(
          position, bufferedPosition, duration ?? Duration.zero),
    );

    Future<void> handleAddImage() async {
      imagesProvider.setCroppedImageFile = null;
      await imagesProvider.pickImage();
      String newPath = imagesProvider.imageFile!.path.split('/').last;
      await imagesProvider.cropImage(imageFile: imagesProvider.imageFile);
      if (imagesProvider.croppedImageFile != null) {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => ImagePopUp(
            add: () async {
              if (await audioProvider.addImageAudio(
                  title: newPath,
                  imagePath: imagesProvider.croppedImagePath,
                  audioId: audioProvider.currAudio!.id)) {
                ScaffoldMessenger.of(context).removeCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: successColor,
                    content: const Text(
                      'Add image successfuly',
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
                galleryProvider.addImageGalleryFromAudio(
                    image: audioProvider.currAudio!.images.last);
              } else {
                ScaffoldMessenger.of(context).removeCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: alertColor,
                    content: Text(
                      audioProvider.errorMessage,
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              }
            },
          ),
        );
      }
    }

    Future<void> handleDeleteImage(ImageModel imageDel) async {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => DeletePopUp(
          delete: () async {
            if (await audioProvider.deleteImageAudio(
                audioId: audioProvider.currAudio!.id, imageId: imageDel.id)) {
              ScaffoldMessenger.of(context).removeCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: successColor,
                  content: const Text(
                    'Delete image successfuly',
                    textAlign: TextAlign.center,
                  ),
                ),
              );
              galleryProvider.deleteImageGalleryFromAudio(image: imageDel);
            } else {
              ScaffoldMessenger.of(context).removeCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: alertColor,
                  content: Text(
                    galleryProvider.errorMessage,
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }
          },
        ),
      );
    }

    Widget header() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(
              Icons.keyboard_arrow_down_rounded,
              color: userProvider.user.role == "USER"
                  ? primaryUserColor
                  : primaryAdminColor,
            ),
          ),
          Text(
            "Playing From",
            textAlign: TextAlign.center,
            style: (userProvider.user.role == "USER"
                    ? primaryUserColorText
                    : primaryAdminColorText)
                .copyWith(fontSize: 12),
          ),
          Visibility(
            visible: userProvider.user.role == "ADMIN",
            child: GestureDetector(
              onTap: () async {
                await handleAddImage();
              },
              child: Icon(
                Icons.add_a_photo,
                color: primaryAdminColor,
              ),
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
              "${playlistProvider.currentPlaylistName} Playlist",
              style: (userProvider.user.role == "USER"
                      ? primaryUserColorText
                      : primaryAdminColorText)
                  .copyWith(fontSize: 16, fontWeight: bold),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(
              height: 75,
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                StreamBuilder<SequenceState?>(
                  stream: audioPlayerProvider.audioPlayer.sequenceStateStream,
                  builder: (context, snapshot) {
                    final state = snapshot.data;
                    if (state?.sequence.isEmpty ?? true) {
                      return const SizedBox();
                    }
                    MediaItem audioJson = state!.currentSource!.tag;
                    AudioModel audio = AudioModel.fromJson(audioJson.extras!);
                    audioProvider.updateHistory(audio: audio);
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        (audioProvider.currAudio!.images.isEmpty
                            ? const DefaultImage(
                                type: ImageType.player, size: 280)
                            : CarouselSlider(
                                items: audioProvider.currAudio!.images
                                    .map((image) {
                                  return GestureDetector(
                                    onTap: () async {
                                      await showDialog(
                                          barrierColor:
                                              Color.fromARGB(236, 0, 0, 0),
                                          barrierDismissible: true,
                                          context: context,
                                          builder: (_) => Container(
                                                padding: const EdgeInsets.only(
                                                    right: 10,
                                                    left: 10,
                                                    top: 160),
                                                child: Align(
                                                  alignment:
                                                      Alignment.topCenter,
                                                  child: CarouselSlider(
                                                    items: audioProvider
                                                        .currAudio!.images
                                                        .map((image) {
                                                      return Stack(
                                                        alignment:
                                                            Alignment.topRight,
                                                        children: [
                                                          CachedNetworkImage(
                                                            imageUrl: image.url,
                                                            fit: BoxFit.cover,
                                                            placeholder:
                                                                (context,
                                                                        url) =>
                                                                    Container(
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                          ),
                                                          GestureDetector(
                                                              onTap: () =>
                                                                  Navigator.pop(
                                                                      context),
                                                              child: Container(
                                                                margin:
                                                                    const EdgeInsets
                                                                        .all(5),
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            180),
                                                                    color: Colors
                                                                        .black),
                                                                child:
                                                                    const Icon(
                                                                  Icons.close,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              )),
                                                        ],
                                                      );
                                                    }).toList(),
                                                    options: CarouselOptions(
                                                      autoPlay:
                                                          audio.images.length >
                                                              1,
                                                      enableInfiniteScroll:
                                                          audio.images.length >
                                                              1,
                                                      viewportFraction: 1,
                                                      enlargeCenterPage: false,
                                                      aspectRatio: 1,
                                                      autoPlayAnimationDuration:
                                                          const Duration(
                                                              milliseconds:
                                                                  2000),
                                                      autoPlayInterval:
                                                          const Duration(
                                                              seconds: 5),
                                                    ),
                                                  ),
                                                ),
                                              ));
                                    },
                                    child: Stack(
                                      alignment: Alignment.topRight,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(32),
                                          child: CachedNetworkImage(
                                            imageUrl: image.url,
                                            width: 280,
                                            height: 280,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Visibility(
                                          visible:
                                              userProvider.user.role == "ADMIN",
                                          child: PopupMenuButton(
                                            icon: Icon(
                                              Icons.more_vert,
                                              color: primaryUserColor,
                                            ),
                                            color: const Color.fromARGB(
                                                255, 223, 223, 223),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      defaultRadius),
                                            ),
                                            elevation: 4,
                                            onSelected: (value) {
                                              if (value == 0) {
                                                handleDeleteImage(image);
                                              }
                                            },
                                            itemBuilder:
                                                (BuildContext context) => [
                                              PopupMenuItem(
                                                value: 0,
                                                child: Text(
                                                  "Delete",
                                                  style: primaryAdminColorText,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                                options: CarouselOptions(
                                  autoPlay: audio.images.length > 1,
                                  enableInfiniteScroll: audio.images.length > 1,
                                  viewportFraction: 1,
                                  enlargeCenterPage: false,
                                  height: 280,
                                  autoPlayAnimationDuration:
                                      const Duration(milliseconds: 2000),
                                  autoPlayInterval: const Duration(seconds: 5),
                                ),
                              )),
                        const SizedBox(
                          height: 45,
                        ),
                        Text(
                          audio.title,
                          style: (userProvider.user.role == "USER"
                                  ? primaryUserColorText
                                  : primaryAdminColorText)
                              .copyWith(
                            fontSize: 16,
                            fontWeight: bold,
                          ),
                        ),
                      ],
                    );
                  },
                ),
                Visibility(
                  visible: userProvider.user.role == "USER" &&
                      adsProvider.adsPlayer.isNotEmpty,
                  child: AdsBannerPlayer(
                    listOfAds: adsProvider.adsPlayer,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            StreamBuilder<PositionDataModel>(
                stream: positionDataStream,
                builder: (context, snapshot) {
                  final positionData = snapshot.data;
                  return Container(
                    margin: const EdgeInsets.only(top: 5, bottom: 30),
                    width: double.infinity,
                    child: ProgressBar(
                      timeLabelLocation: TimeLabelLocation.above,
                      timeLabelPadding: 8,
                      timeLabelTextStyle: (userProvider.user.role == "USER"
                              ? primaryUserColorText
                              : primaryAdminColorText)
                          .copyWith(fontSize: 12),
                      barHeight: 8,
                      baseBarColor: backgroundProgressIndicatorColor,
                      bufferedBarColor: Colors.transparent,
                      progressBarColor: progressIndicatorColor,
                      thumbRadius: 8,
                      thumbColor: Colors.transparent,
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
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        padding: EdgeInsets.symmetric(horizontal: defaultMargin, vertical: 32),
        children: [
          header(),
          music(),
        ],
      );
    }

    return Scaffold(
      backgroundColor: userProvider.user.role == "USER"
          ? backgroundUserColor
          : backgroundAdminColor,
      body: GestureDetector(
        onVerticalDragUpdate: (details) {
          if (details.delta.direction > 0) {
            Navigator.of(context).pop(true);
          }
        },
        child: SafeArea(
          child: content(),
        ),
      ),
    );
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
    UserProvider userProvider = Provider.of<UserProvider>(context);

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

                  // save local
                  final pref = await SharedPreferences.getInstance();
                  await pref.setBool('shuffle', enable);
                },
                child: Icon(
                  Icons.shuffle,
                  color: snapshot.data ?? false
                      ? secondaryColor
                      : (userProvider.user.role == "USER"
                          ? primaryUserColor
                          : primaryAdminColor),
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
            color: userProvider.user.role == "USER"
                ? primaryUserColor
                : primaryAdminColor,
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
            color: userProvider.user.role == "USER"
                ? primaryUserColor
                : primaryAdminColor,
            size: 34,
          ),
        ),
        StreamBuilder<LoopMode>(
            stream: audioPlayerProvider.audioPlayer.loopModeStream,
            builder: (context, snapshot) {
              final current = snapshot.data;
              return GestureDetector(
                onTap: () async {
                  final pref = await SharedPreferences.getInstance();
                  if (current == LoopMode.all) {
                    await audioPlayerProvider.audioPlayer
                        .setLoopMode(LoopMode.one);
                    await pref.setString('loop', 'one');
                  }
                  if (current == LoopMode.one) {
                    await audioPlayerProvider.audioPlayer
                        .setLoopMode(LoopMode.off);
                    await pref.setString('loop', 'off');
                  }
                  if (current == LoopMode.off) {
                    await audioPlayerProvider.audioPlayer
                        .setLoopMode(LoopMode.all);
                    await pref.setString('loop', 'all');
                  }
                },
                child: Icon(
                  current == LoopMode.one ? Icons.repeat_one : Icons.repeat,
                  color: current == LoopMode.off
                      ? (userProvider.user.role == "USER"
                          ? primaryUserColor
                          : primaryAdminColor)
                      : secondaryColor,
                  size: 28,
                ),
              );
            }),
      ],
    );
  }
}
