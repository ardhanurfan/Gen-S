import 'dart:convert';

import 'package:music_player/models/audio_model.dart';
import 'package:music_player/services/url_service.dart';

import 'package:http/http.dart' as http;
import 'package:music_player/services/user_service.dart';

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

  Future<AudioModel> addAudio({
    required String title,
    required String audioPath,
    required List<String> imagesPath,
  }) async {
    late Uri url = UrlService().api('add-audio');

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': await UserService().getTokenPreference() ?? '',
    };

    var request = http.MultipartRequest('POST', url);

    // add headers
    request.headers.addAll(headers);

    // add title
    request.fields['title'] = title;

    // add audio
    request.files
        .add(await http.MultipartFile.fromPath('audioFile', audioPath));

    // add images
    for (var imagePath in imagesPath) {
      request.files.add(await http.MultipartFile.fromPath('images', imagePath));
    }

    var response = await request.send();

    var responsed = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      var data = jsonDecode(responsed.body)['data'];
      return AudioModel.fromJson(data);
    } else {
      throw "Add audio failed";
    }
  }

  Future<bool> deleteAudio({required int audioId}) async {
    late Uri url = UrlService().api('delete-audio');
    var headers = {
      'Content-Type': 'application/json',
    };

    var body = {
      'id': audioId,
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
      throw "Delete audio failed";
    }
  }

  Future<bool> updateHistory({required int audioId}) async {
    late Uri url = UrlService().api('history');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': await UserService().getTokenPreference() ?? '',
    };

    var body = {
      'audioId': audioId,
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
      throw "Update audio failed";
    }
  }
}
