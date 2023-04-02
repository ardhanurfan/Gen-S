import 'dart:convert';

import 'package:music_player/models/ads_model.dart';
import 'package:music_player/services/url_service.dart';

import 'package:http/http.dart' as http;

class AdsService {
  Future<List<AdsModel>> getAds() async {
    var url = UrlService().api('ads');

    var headers = {
      'Content-Type': 'application/json',
    };

    var response = await http.get(
      url,
      headers: headers,
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'] as List;
      List<AdsModel> ads = List<AdsModel>.from(
        data.map((e) => AdsModel.fromJson(e)),
      );
      return ads;
    } else {
      throw "Get ads failed";
    }
  }

  Future<AdsModel> addAds({
    required String frequency,
    required String contentPath,
    required String title,
    required String link,
  }) async {
    late Uri url = UrlService().api('add-ads');

    var headers = {
      'Content-Type': 'application/json',
    };

    var request = http.MultipartRequest('POST', url);

    // add headers
    request.headers.addAll(headers);

    // add freq
    request.fields['frequency'] = frequency;
    // add link
    request.fields['link'] = link;
    // add title
    request.fields['title'] = title;

    // add content
    request.files
        .add(await http.MultipartFile.fromPath('adsFile', contentPath));

    var response = await request.send();

    var responsed = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      var data = jsonDecode(responsed.body)['data'];
      return AdsModel.fromJson(data);
    } else {
      throw "All form is required";
    }
  }

  Future<bool> deleteAds({required int adsId}) async {
    late Uri url = UrlService().api('delete-ads');
    var headers = {
      'Content-Type': 'application/json',
    };

    var body = {
      'id': adsId,
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
      throw "Delete ads failed";
    }
  }

  Future<AdsModel> editAds({
    required String frequency,
    required int adsId,
    required String link,
    required String title,
  }) async {
    late Uri url = UrlService().api('edit-ads');
    var headers = {
      'Content-Type': 'application/json',
    };

    var body = {
      'id': adsId,
      'frequency': int.parse(frequency),
      'link': link,
      'title': title,
    };

    var response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(body),
      encoding: Encoding.getByName('utf-8'),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      return AdsModel.fromJson(data);
    } else {
      throw "Edit ads failed";
    }
  }
}
