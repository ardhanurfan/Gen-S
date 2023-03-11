import 'package:flutter/cupertino.dart';
import 'package:music_player/models/playlist_model.dart';
import 'package:music_player/services/playlist_services.dart';

class PlaylistProvider extends ChangeNotifier {
  List<PlaylistModel> _playlists = [];

  List<PlaylistModel> get playlists => _playlists;

  Future<void> getPlaylist({required String token}) async {
    try {
      List<PlaylistModel> playlists =
          await PlaylistService().getPlaylists(token: token);
      _playlists = playlists;
    } catch (e) {
      rethrow;
    }
  }
}
