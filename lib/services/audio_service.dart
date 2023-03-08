import 'dart:convert';

import 'package:music_player/models/audio_model.dart';
import 'package:music_player/services/url_service.dart';

import 'package:http/http.dart' as http;

class AudioService {
  Future<List<AudioModel>> getAudios({
    required String token,
    String search = '',
  }) async {
    late Uri url;
    if (search.isEmpty) {
      url = UrlService().api('audio');
    } else {
      url = UrlService().api('audio?title=$search');
    }

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };

    var response = await http.get(
      url,
      headers: headers,
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'] as List;
      List<AudioModel> audios = List<AudioModel>.from(
        data.map((e) => AudioModel.fromJson(e)),
      );
      return audios;
    } else {
      throw "Get audio failed";
    }
  }

  Future<List<AudioModel>> getHistory({
    required String token,
    bool isMost = false,
  }) async {
    late Uri url =
        UrlService().api('history?limit=30${isMost ? '&menu=MOST' : ''}');

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };

    var response = await http.get(
      url,
      headers: headers,
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data']['data'] as List;
      List<AudioModel> history = List<AudioModel>.from(
        data.map((e) => AudioModel.fromJson(e['audio'])),
      );
      return history;
    } else {
      throw "Get history failed";
    }
  }
}
