import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:music_player/models/ads_model.dart';
import 'package:url_launcher/url_launcher.dart';

class AdsBanner extends StatelessWidget {
  const AdsBanner({super.key, required this.listOfAds});
  final List<AdsModel> listOfAds;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      disableGesture: true,
      items: listOfAds.map((e) {
        return GestureDetector(
            onTap: () async {
              await _launchURL(e.link);
            },
            child: Image.network(
              e.url,
              width: double.infinity,
              fit: BoxFit.cover,
            ));
      }).toList(),
      options: CarouselOptions(
        autoPlay: true,
        enableInfiniteScroll: true,
        viewportFraction: 1,
        enlargeCenterPage: false,
        height: 60,
        autoPlayAnimationDuration: const Duration(milliseconds: 2000),
        autoPlayInterval: const Duration(seconds: 6),
      ),
    );
  }

  _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.platformDefault);
    } else {
      throw 'Could not launch $url';
    }
  }
}
