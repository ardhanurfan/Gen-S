import 'dart:async';

import 'package:flutter/material.dart';
import 'package:music_player/models/ads_model.dart';
import 'package:url_launcher/url_launcher.dart';

class AdsBannerPlayer extends StatefulWidget {
  const AdsBannerPlayer({super.key, required this.listOfAds});
  final List<AdsModel> listOfAds;

  @override
  State<AdsBannerPlayer> createState() => _AdsBannerPlayerState();
}

class _AdsBannerPlayerState extends State<AdsBannerPlayer> {
  bool isAds = true;
  late AdsModel ads = widget.listOfAds[0];
  int index = 0;

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    super.initState();
    widget.listOfAds.shuffle();
    Timer.periodic(
      const Duration(minutes: 1),
      (timer) async {
        setState(() {
          if (!isAds) {
            isAds = true;
          }

          ads = widget.listOfAds[index];
        });
        index++;
        index = index == widget.listOfAds.length ? 0 : index;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: isAds ? 1 : 0,
      duration: const Duration(milliseconds: 500),
      child: GestureDetector(
        onTap: () async {
          if (isAds) {
            await _launchURL(ads.link);
          }
        },
        child: Container(
          alignment: Alignment.topRight,
          height: 280,
          width: 280,
          margin: const EdgeInsets.only(bottom: 70),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(ads.url),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                spreadRadius: 50,
                blurRadius: 50,
              ),
            ],
          ),
          child: GestureDetector(
            onTap: () {
              setState(() {
                isAds = false;
              });
            },
            child: const Icon(
              Icons.cancel,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  _launchURL(String url) async {
    Uri uri = Uri.parse(url);
    if (!(url.startsWith("http://") || url.startsWith("https://"))) {
      uri = Uri.parse("http://$url");
    }
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }
}
