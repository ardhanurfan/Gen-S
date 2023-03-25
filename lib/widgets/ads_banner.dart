import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:music_player/models/ads_model.dart';
import 'package:music_player/providers/ads_provider.dart';
import 'package:provider/provider.dart';

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

  @override
  void initState() {
    AdsProvider adsProvider = Provider.of<AdsProvider>(context, listen: false);

    Future<void> setAds(Timer timer) async {}

    _timer = Timer.periodic(const Duration(seconds: 1), setAds);
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: curr != null ? Text(curr!) : Text('kosong'),
    );
  }
}
