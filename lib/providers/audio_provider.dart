import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:music_player/models/audio_model.dart';
import 'package:music_player/services/audio_service.dart';
import 'package:music_player/services/user_service.dart';

class AudioProvider extends ChangeNotifier {
  List<AudioModel> _audios = [];
  List<AudioModel> _historyMosts = [];
  List<AudioModel> _historyRecents = [];
  String _audioPickedPath = '';
  String _errorMessage = '';
  AudioModel? _currAudio;

  List<AudioModel> get audios => _audios;
  List<AudioModel> get historyMosts => _historyMosts;
  List<AudioModel> get historyRecents => _historyRecents;
  String get audioPickedPath => _audioPickedPath;
  String get errorMessage => _errorMessage;

  Future<void> getAudios({required String token}) async {
    try {
      List<AudioModel> audios = await AudioService().getAudios(token: token);
      _audios = audios;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> getHistory({required String token}) async {
    try {
      List<AudioModel> historyMosts =
          await AudioService().getHistory(token: token, isMost: true);
      List<AudioModel> historyRecents =
          await AudioService().getHistory(token: token);

      _historyMosts = historyMosts;
      _historyRecents = historyRecents;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateHistory({required AudioModel audio}) async {
    try {
      if (_currAudio == null || _currAudio != audio) {
        _currAudio = audio;
        if (await AudioService().updateHistory(audioId: audio.id)) {
          var token = await UserService().getTokenPreference() ?? '';
          List<AudioModel> historyMosts =
              await AudioService().getHistory(token: token, isMost: true);
          List<AudioModel> historyRecents =
              await AudioService().getHistory(token: token);

          _historyMosts = historyMosts;
          _historyRecents = historyRecents;
          notifyListeners();
        }
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> audioPicker() async {
    try {
      var result = await FilePicker.platform.pickFiles(type: FileType.audio);
      _audioPickedPath = result!.files.first.path!;
      return true;
    } catch (e) {
      _errorMessage = "Pick audio canceled";
      return false;
    }
  }

  Future<bool> addAudio({
    required String title,
    required String audioPath,
    required List<String> imagesPath,
  }) async {
    try {
      AudioModel audio = await AudioService().addAudio(
        title: title,
        audioPath: audioPath,
        imagesPath: imagesPath,
      );
      _audios.insert(0, audio);
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    }
  }

  Future<bool> deleteAudio({required int audioId}) async {
    try {
      await AudioService().deleteAudio(audioId: audioId);
      var audioDel = _audios.firstWhere(
        (element) => element.id == audioId,
      );
      _audios.remove(audioDel);
      _historyMosts.remove(audioDel);
      _historyRecents.remove(audioDel);
      notifyListeners();

      return true;
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    }
  }

  void sortByDate() {
    _audios.sort(
      (a, b) => b.createdAt.compareTo(a.createdAt),
    );
    notifyListeners();
  }

  void sortAscending() {
    _audios.sort(
      (a, b) => a.title.compareTo(b.title),
    );
    notifyListeners();
  }

  void sortDescending() {
    _audios.sort(
      (a, b) => b.title.compareTo(a.title),
    );
    notifyListeners();
  }
}
