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
    required int frequency,
    required String contentPath,
  }) async {
    late Uri url = UrlService().api('add-ads');

    var headers = {
      'Content-Type': 'application/json',
    };

    var request = http.MultipartRequest('POST', url);

    // add headers
    request.headers.addAll(headers);

    // add freq
    request.fields['frequency'] = frequency.toString();

    // add content
    request.files
        .add(await http.MultipartFile.fromPath('adsFile', contentPath));

    var response = await request.send();

    var responsed = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      var data = jsonDecode(responsed.body)['data'];
      return AdsModel.fromJson(data);
    } else {
      throw "Add ads failed";
    }
  }

  Future<bool> deleteAudio({required int adsId}) async {
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
}
