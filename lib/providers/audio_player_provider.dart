import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';

import '../models/audio_model.dart';

class AudioPlayerProvider extends ChangeNotifier {
  late AudioPlayer _audioPlayer;
  late ConcatenatingAudioSource _playlist;
  List<AudioModel> _currentPlaylist = [];
  late int _currentAudioId = 0;

  AudioPlayer get audioPlayer => _audioPlayer;
  ConcatenatingAudioSource get playlist => _playlist;
  List<AudioModel> get currentPlaylist => _currentPlaylist;
  int get currentAudioId => _currentAudioId;

  void init() {
    _audioPlayer = AudioPlayer();
  }

  Future<void> setPlay(List<AudioModel> playlist, int index) async {
    if (!listEquals(_currentPlaylist, playlist)) {
      _playlist = ConcatenatingAudioSource(
        children: playlist
            .map(
              (audio) => AudioSource.uri(Uri.parse(audio.url)),
            )
            .toList(),
      );
      _currentPlaylist = playlist;
      await _audioPlayer.setAudioSource(_playlist);
    }

    _currentAudioId = playlist[index].id;
    notifyListeners();

    await _audioPlayer.seek(const Duration(seconds: 0), index: index);
    _audioPlayer.play();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}