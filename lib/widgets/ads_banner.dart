import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
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
  List<AdsModel> listOfAds = [];

  void playVideo(
      {int index = 0, bool init = false, required List<AdsModel> ads}) {
    if (index < 0 || index >= ads.length) return;
    _controller = VideoPlayerController.network(ads[_counter].url)
      ..addListener(() => setState(() {}))
      ..setLooping(true)
      ..initialize().then((value) => _controller.play());
  }

  @override
  void initState() {
    AdsProvider adsProvider = Provider.of<AdsProvider>(context, listen: false);
    listOfAds = adsProvider.ads;
    playVideo(init: true, ads: listOfAds);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Timer.periodic(const Duration(seconds: 5), (timer) {
      if (_counter == listOfAds.length) {
        _counter = 0;
      }

      playVideo(ads: listOfAds, index: _counter);

      _counter++;
    });

    return _controller.value.isInitialized
        ? CarouselSlider(
            disableGesture: true,
            items: listOfAds.map((e) {
              return Container(
                  height: 59,
                  width: double.infinity,
                  child: Stack(children: [
                    GestureDetector(
                        onTap: () async {
                          await _launchURL(e.link);
                        },
                        child: VideoPlayer(_controller)),
                    Align(
                      alignment: Alignment.topRight,
                      child: Icon(
                        Icons.close,
                        color: backgroundUserColor,
                      ),
                    )
                  ]));
            }).toList(),
            options: CarouselOptions(
              autoPlay: true,
              enableInfiniteScroll: true,
              viewportFraction: 1,
              enlargeCenterPage: false,
              height: 59,
              autoPlayAnimationDuration: const Duration(milliseconds: 2000),
              autoPlayInterval: const Duration(seconds: 6),
            ),
          )
        : const Text("No Ads");
  }

  _launchURL(String url) async {
    url = url;
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.platformDefault);
    } else {
      throw 'Could not launch $url';
    }
  }
}
