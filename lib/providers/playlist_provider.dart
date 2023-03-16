import 'package:flutter/cupertino.dart';
import 'package:music_player/models/playlist_model.dart';
import 'package:music_player/services/playlist_service.dart';

class PlaylistProvider extends ChangeNotifier {
  List<PlaylistModel> _playlists = [];

  List<PlaylistModel> get playlists => _playlists;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  Future<void> getPlaylist({required String token}) async {
    try {
      List<PlaylistModel> playlists =
          await PlaylistService().getPlaylists(token: token);
      _playlists = playlists;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> addPlaylist({required String name}) async {
    try {
      return await PlaylistService().addPlaylist(name: name);
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    }
  }
}
