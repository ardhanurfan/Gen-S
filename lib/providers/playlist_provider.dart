import 'package:flutter/cupertino.dart';
import 'package:music_player/models/audio_model.dart';
import 'package:music_player/models/playlist_model.dart';
import 'package:music_player/services/playlist_service.dart';

class PlaylistProvider extends ChangeNotifier {
  List<PlaylistModel> _playlists = [];
  List<AudioModel> _audios = [];
  String _errorMessage = '';

  String get errorMessage => _errorMessage;
  List<PlaylistModel> get playlists => _playlists;
  List<AudioModel> get audios => _audios;

  set setAudios(List<AudioModel> audios) {
    _audios = audios;
    notifyListeners();
  }

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
      var backup = _playlists;
      if (oldIndex < newIndex) {
        newIndex -= 1;
      }
      final PlaylistModel item = _playlists.removeAt(oldIndex);
      _playlists.insert(newIndex, item);
      notifyListeners();

      // jika gagal dikembalikan
      if (!(await PlaylistService().swapPlaylist(playlist: _playlists))) {
        _playlists = backup;
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

  Future<bool> swapAudio({
    required int playlistId,
    required int oldIndex,
    required int newIndex,
  }) async {
    try {
      var backup = _audios;
      if (oldIndex < newIndex) {
        newIndex -= 1;
      }
      final AudioModel item = _audios.removeAt(oldIndex);
      _audios.insert(newIndex, item);
      notifyListeners();

      // jika gagal dikembalikan
      if (!(await PlaylistService()
          .swapAudio(playlistId: playlistId, audios: _audios))) {
        _audios = backup;
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
