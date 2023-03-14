import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';

import '../models/audio_model.dart';

class AudioPlayerProvider extends ChangeNotifier {
  late AudioPlayer _audioPlayer;
  late ConcatenatingAudioSource _playlist;
  List<AudioModel> _currentPlaylist = [];
  late AudioModel _currentAudio;

  AudioPlayer get audioPlayer => _audioPlayer;
  ConcatenatingAudioSource get playlist => _playlist;
  List<AudioModel> get currentPlaylist => _currentPlaylist;

  AudioModel get currentAudio => _currentAudio;

  void init() {
    _audioPlayer = AudioPlayer();
    _currentAudio = const AudioModel(id: -1, title: '', url: '', images: []);
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
      notifyListeners();
      await _audioPlayer.setAudioSource(_playlist);
    }

    _currentAudio = _currentPlaylist[index];
    notifyListeners();

    await _audioPlayer.seek(const Duration(seconds: 0), index: index);
    _audioPlayer.play();
  }

  void updateAudio() {
    _currentAudio = _currentPlaylist[_audioPlayer.currentIndex!];
    notifyListeners();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}
