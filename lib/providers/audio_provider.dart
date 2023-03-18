import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:music_player/models/audio_model.dart';
import 'package:music_player/services/audio_service.dart';

class AudioProvider extends ChangeNotifier {
  List<AudioModel> _audios = [];
  List<AudioModel> _historyMosts = [];
  List<AudioModel> _historyRecents = [];
  String _audioPickedPath = '';
  String _errorMessage = '';

  List<AudioModel> get audios => _audios;
  List<AudioModel> get historyMosts => _historyMosts;
  List<AudioModel> get historyRecents => _historyRecents;
  String get audioPickedPath => _audioPickedPath;
  String get errorMessage => _errorMessage;

  set audios(List<AudioModel> audios) {
    _audios = audios;
    notifyListeners();
  }

  set historyMosts(List<AudioModel> historyMosts) {
    _historyMosts = historyMosts;
    notifyListeners();
  }

  set historyRecents(List<AudioModel> historyRecents) {
    _historyRecents = historyRecents;
    notifyListeners();
  }

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
}
