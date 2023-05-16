import 'package:flutter/cupertino.dart';
import 'package:music_player/models/audio_model.dart';
import 'package:music_player/models/playlist_model.dart';
import 'package:music_player/services/playlist_service.dart';

class PlaylistProvider extends ChangeNotifier {
  List<PlaylistModel> _playlists = [];
  List<AudioModel> _audios = [];
  String _errorMessage = '';
  String _currentPlaylistName = '';

  String get errorMessage => _errorMessage;
  List<PlaylistModel> get playlists => _playlists;
  List<AudioModel> get audios => _audios;
  String get currentPlaylistName => _currentPlaylistName;

  set setCurrentPlaylistName(String name) {
    _currentPlaylistName = name;
    notifyListeners();
  }

  set setAudios(List<AudioModel> audios) {
    _audios = audios;
    notifyListeners();
  }

  Future<bool> addAudio(
      {required AudioModel audio, required int playlistId}) async {
    try {
      await PlaylistService()
          .addAudio(audioId: audio.id, playlistId: playlistId);
      _playlists
          .where((element) => element.id == playlistId)
          .first
          .audios
          .add(audio);
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    }
  }

  Future<bool> deleteAudio(
      {required AudioModel audio, required int playlistId}) async {
    try {
      await PlaylistService()
          .deleteAudio(audioId: audio.id, playlistId: playlistId);
      _playlists
          .where((element) => element.id == playlistId)
          .first
          .audios
          .remove(audio);
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    }
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

  Future<bool> renamePlaylist(
      {required String name, required int playlistId}) async {
    try {
      PlaylistModel newPlaylist =
          await PlaylistService().rename(name: name, playlistId: playlistId);
      var index = _playlists.indexOf(
        _playlists.firstWhere(
          (element) => element.id == playlistId,
        ),
      );
      _playlists.removeAt(index);
      _playlists.insert(index, newPlaylist);
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
      if (oldIndex < newIndex) {
        newIndex -= 1;
      }
      final PlaylistModel item = _playlists.removeAt(oldIndex);
      _playlists.insert(newIndex, item);
      notifyListeners();

      return await PlaylistService().swapPlaylist(playlist: _playlists);
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
      if (oldIndex < newIndex) {
        newIndex -= 1;
      }
      final AudioModel item = _audios.removeAt(oldIndex);
      _audios.insert(newIndex, item);
      notifyListeners();

      return await PlaylistService()
          .swapAudio(playlistId: playlistId, audios: _audios);
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    }
  }

  Future<bool> deletePlaylist({required int playlistId}) async {
    try {
      await PlaylistService().deletePlaylist(playlistId: playlistId);
      var index = _playlists.indexOf(
        _playlists.firstWhere(
          (element) => element.id == playlistId,
        ),
      );
      _playlists.removeAt(index);
      notifyListeners();

      return true;
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    }
  }

  void deleteAudioFromAllPlaylist({required int audioId}) {
    for (var element in _playlists) {
      var found = element.audios.where(
        (element) => element.id == audioId,
      );

      if (found.isNotEmpty) {
        var index = element.audios.indexOf(found.first);
        element.audios.removeAt(index);
      }
    }
    notifyListeners();
  }

  void renameAudioFromAllPlaylist(
      {required int audioId, required String newTitle}) {
    for (var element in _playlists) {
      var index = element.audios.indexOf(
        element.audios.firstWhere(
          (audio) => audio.id == audioId,
        ),
      );
      if (index != -1) {
        AudioModel old = element.audios[index];
        AudioModel newAudio = AudioModel(
          id: old.id,
          title: newTitle,
          url: old.url,
          uploaderId: old.uploaderId,
          createdAt: old.createdAt,
          images: old.images,
        );
        element.audios.removeAt(index);
        element.audios.insert(index, newAudio);
      }
    }
    notifyListeners();
  }
}
