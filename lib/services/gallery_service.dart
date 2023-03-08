import 'dart:convert';

import 'package:music_player/models/gallery_model.dart';

import 'url_service.dart';

import 'package:http/http.dart' as http;

class GalleryService {
  Future<List<GalleryModel>> getGalleries({String search = ''}) async {
    late Uri url;
    if (search.isEmpty) {
      url = UrlService().api('gallery');
    } else {
      url = UrlService().api('gallery?name=$search');
    }

    var headers = {
      'Content-Type': 'application/json',
    };

    var response = await http.get(
      url,
      headers: headers,
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'] as List;
      List<GalleryModel> galleries = List<GalleryModel>.from(
        data.map((e) => GalleryModel.fromJson(e)),
      );
      return galleries;
    } else {
      throw "Get gallery failed";
    }
  }
}
