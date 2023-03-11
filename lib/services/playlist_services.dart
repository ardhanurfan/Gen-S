import 'dart:convert';

import 'package:music_player/models/playlist_model.dart';
import 'package:music_player/services/url_service.dart';

import 'package:http/http.dart' as http;

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
}
