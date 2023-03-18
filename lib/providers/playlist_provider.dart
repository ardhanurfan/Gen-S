import 'package:flutter/cupertino.dart';
import 'package:music_player/models/playlist_model.dart';
import 'package:music_player/services/playlist_service.dart';

class PlaylistProvider extends ChangeNotifier {
  List<PlaylistModel> _playlists = [];
  String _errorMessage = '';

  String get errorMessage => _errorMessage;
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

  Future<bool> addPlaylist({required String name}) async {
    try {
      _playlists.add(await PlaylistService().addPlaylist(name: name));
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    }
  }

  Future<bool> swapPlaylist(
      {required int oldIndex, required int newIndex}) async {
    try {
      PlaylistModel from = playlists[oldIndex];
      PlaylistModel to = playlists[newIndex];
      playlists[oldIndex] = to;
      playlists[newIndex] = from;
      notifyListeners();

      // jika gagal dikembalikan
      if (!(await PlaylistService()
          .swapPlaylist(toId: to.id, fromId: from.id))) {
        PlaylistModel from = playlists[oldIndex];
        PlaylistModel to = playlists[newIndex];
        playlists[oldIndex] = to;
        playlists[newIndex] = from;
        notifyListeners();
        return false;
      } else {
        return true;
      }
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    }
  }
}
