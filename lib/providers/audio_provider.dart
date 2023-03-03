import 'package:flutter/cupertino.dart';
import 'package:music_player/models/audio_model.dart';
import 'package:music_player/services/audio_service.dart';

class AudioProvider extends ChangeNotifier {
  List<AudioModel> _audios = [];
  List<AudioModel> _historyMosts = [];
  List<AudioModel> _historyRecents = [];

  List<AudioModel> get audios => _audios;
  List<AudioModel> get historyMosts => _historyMosts;
  List<AudioModel> get historyRecents => _historyRecents;

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
}
