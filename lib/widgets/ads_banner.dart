import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:music_player/models/ads_model.dart';
import 'package:music_player/shared/theme.dart';
import 'package:url_launcher/url_launcher.dart';

class AdsBanner extends StatelessWidget {
  const AdsBanner({super.key, required this.listOfAds});
  final List<AdsModel> listOfAds;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      disableGesture: true,
      items: listOfAds.map((e) {
        return Stack(children: [
          GestureDetector(
              onTap: () async {
                print(e.link);
                await _launchURL(e.link);
              },
              child: Image.network(
                e.url,
                width: double.infinity,
                fit: BoxFit.cover,
              )),
          Align(
            alignment: Alignment.topRight,
            child: Icon(
              Icons.close,
              color: backgroundUserColor,
            ),
          )
        ]);
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
    Uri uri = Uri.parse(url);
    if (!url.startsWith("http://") && !url.startsWith("https://")) {
      uri = Uri.parse("http://$url");
    }
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.platformDefault);
    } else {
      throw 'Could not launch $url';
    }
  }
}
