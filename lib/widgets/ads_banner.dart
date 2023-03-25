import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:music_player/models/ads_model.dart';
import 'package:music_player/providers/ads_provider.dart';
import 'package:music_player/shared/theme.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

class AdsBanner extends StatefulWidget {
  const AdsBanner({super.key});

  @override
  State<AdsBanner> createState() => _AdsBannerState();
}

class _AdsBannerState extends State<AdsBanner> {
  AdsModel? currAds;
  String? curr;
  late Timer _timer;
  int _counter = 0;
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    AdsProvider adsProvider = Provider.of<AdsProvider>(context, listen: false);
    _controller = VideoPlayerController.network(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _controller.setVolume(0);
          _controller.play(); // auto play
        });
      });

    Future<void> setAds(Timer timer) async {}

    _timer = Timer.periodic(const Duration(seconds: 1), setAds);
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 59,
      width: double.infinity,
      child: Stack(children: [
        GestureDetector(onTap: _launchURL, child: VideoPlayer(_controller)),
        Align(
          alignment: Alignment.topRight,
          child: Icon(
            Icons.close,
            color: backgroundUserColor,
          ),
        )
      ]),
    );
  }

  _launchURL() async {
    const url = 'https://www.youtube.com/';
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.platformDefault);
    } else {
      throw 'Could not launch $url';
    }
  }
}
