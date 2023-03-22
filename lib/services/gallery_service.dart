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

  Future<GalleryModel> addGallery({required String name}) async {
    late Uri url = UrlService().api('create-gallery');
    var headers = {
      'Content-Type': 'application/json',
    };

    var body = {
      'name': name,
    };

    var response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(body),
      encoding: Encoding.getByName('utf-8'),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      return GalleryModel.fromJson(data);
    } else {
      throw "Add gallery failed";
    }
  }

  Future<bool> deleteGallery({required int galleryId}) async {
    late Uri url = UrlService().api('delete-gallery');
    var headers = {
      'Content-Type': 'application/json',
    };

    var body = {
      'id': galleryId,
    };

    var response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(body),
      encoding: Encoding.getByName('utf-8'),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw "Delete gallery failed";
    }
  }
}
