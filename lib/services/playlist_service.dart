import 'dart:convert';

import 'package:music_player/models/audio_model.dart';
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

  Future<PlaylistModel> rename(
      {required int playlistId, required String name}) async {
    late Uri url = UrlService().api('rename-playlist');
    var headers = {
      'Content-Type': 'application/json',
    };

    var body = {
      'id': playlistId,
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
      throw "Rename playlist failed";
    }
  }

  Future<bool> swapPlaylist({required List<PlaylistModel> playlist}) async {
    late Uri url = UrlService().api('swap-playlist');
    var headers = {
      'Content-Type': 'application/json',
    };

    var body = {
      'playlists': playlist
          .map((e) => {
                'id': e.id,
                'sequence': playlist.indexOf(e) + 1, // +1 biar mulai dari 1
              })
          .toList(),
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

  Future<bool> swapAudio(
      {required int playlistId, required List<AudioModel> audios}) async {
    late Uri url = UrlService().api('swap-audio-playlist');
    var headers = {
      'Content-Type': 'application/json',
    };

    var body = {
      'playlistId': playlistId,
      'audios': audios
          .map((e) => {
                'audioId': e.id,
                'sequence': audios.indexOf(e) + 1, // +1 biar mulai dari 1
              })
          .toList(),
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
      throw "Swap audio failed";
    }
  }

  Future<bool> deletePlaylist({required int playlistId}) async {
    late Uri url = UrlService().api('delete-playlist');
    var headers = {
      'Content-Type': 'application/json',
    };

    var body = {
      'id': playlistId,
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
      throw "Delete playlist failed";
    }
  }

  Future<bool> addAudio({required int audioId, required int playlistId}) async {
    late Uri url = UrlService().api('add-audio-playlist');
    var headers = {
      'Content-Type': 'application/json',
    };

    var body = {
      'audioId': audioId,
      'playlistId': playlistId,
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
      throw "Add audio to playlist failed";
    }
  }

  Future<bool> deleteAudio(
      {required int audioId, required int playlistId}) async {
    late Uri url = UrlService().api('delete-audio-playlist');
    var headers = {
      'Content-Type': 'application/json',
    };

    var body = {
      'audioId': audioId,
      'playlistId': playlistId,
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
      throw "Delete audio from playlist failed";
    }
  }
}
