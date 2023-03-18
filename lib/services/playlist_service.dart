import 'dart:convert';

import 'package:music_player/models/playlist_model.dart';
import 'package:music_player/services/url_service.dart';

import 'package:http/http.dart' as http;
import 'package:music_player/services/user_service.dart';

class PlaylistService {
  Future<List<PlaylistModel>> getPlaylists({
    required String token,
    String search = '',
  }) async {
    late Uri url;
    if (search.isEmpty) {
      url = UrlService().api('playlist');
    } else {
      url = UrlService().api('playlist?name=$search');
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
      List<PlaylistModel> playlists = List<PlaylistModel>.from(
        data.map((e) => PlaylistModel.fromJson(e)),
      );
      return playlists;
    } else {
      throw "Get gallery failed";
    }
  }

  Future<PlaylistModel> addPlaylist({required String name}) async {
    late Uri url = UrlService().api('add-playlist');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': await UserService().getTokenPreference() ?? '',
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
      return PlaylistModel.fromJson(data);
    } else {
      throw "Add playlist failed";
    }
  }

  Future<bool> swapPlaylist({required int toId, required int fromId}) async {
    late Uri url = UrlService().api('swap-playlist');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': await UserService().getTokenPreference() ?? '',
    };

    var body = {
      'toId': toId,
      'fromId': fromId,
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
      throw "Swap playlist failed";
    }
  }
}