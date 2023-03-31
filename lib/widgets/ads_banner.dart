import 'package:flutter/material.dart';
import 'package:music_player/models/ads_model.dart';
import 'package:music_player/shared/theme.dart';
import 'package:url_launcher/url_launcher.dart';

class AdsBanner extends StatelessWidget {
  const AdsBanner({super.key, required this.ads});
  final AdsModel ads;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 59,
        width: double.infinity,
        child: Stack(children: [
          GestureDetector(
              onTap: () async {
                await _launchURL(ads.url);
              },
              child: Image.network(ads.url)),
          Align(
            alignment: Alignment.topRight,
            child: Icon(
              Icons.close,
              color: backgroundUserColor,
            ),
          )
        ]));
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
