import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';

import '../models/audio_model.dart';

class AudioPlayerProvider extends ChangeNotifier {
  late AudioPlayer _audioPlayer;
  late ConcatenatingAudioSource _playlist;
  List<AudioModel> _currentPlaylist = [];

  AudioPlayer get audioPlayer => _audioPlayer;
  ConcatenatingAudioSource get playlist => _playlist;
  List<AudioModel> get currentPlaylist => _currentPlaylist;

  void init() {
    _audioPlayer = AudioPlayer();
  }

  Future<void> setPlay(List<AudioModel> playlist, int index) async {
    if (!listEquals(_currentPlaylist, playlist)) {
      _playlist = ConcatenatingAudioSource(
        children: playlist
            .map(
              (audio) => AudioSource.uri(
                Uri.parse(audio.url),
                tag: AudioModel(
                  id: audio.id,
                  title: audio.title,
                  url: audio.url,
                  uploaderId: audio.uploaderId,
                  images: audio.images,
                ),
              ),
            )
            .toList(),
      );
      _currentPlaylist = playlist;
      notifyListeners();
      await _audioPlayer.setAudioSource(_playlist, initialIndex: index);
    }

    await _audioPlayer.seek(const Duration(seconds: 0), index: index);
    _audioPlayer.play();
  }

  void addAudio({required AudioModel audio}) {
    if (_currentPlaylist.isNotEmpty) {
      _playlist.insert(0, AudioSource.uri(Uri.parse(audio.url), tag: audio));
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}
