import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_player/models/image_model.dart';

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
                createdAt: audio.createdAt,
                images: audio.images,
              ),
            ),
          )
          .toList(),
    );
    _currentPlaylist = playlist;
    notifyListeners();
    await _audioPlayer.setAudioSource(_playlist, initialIndex: index);

    await _audioPlayer.seek(const Duration(seconds: 0), index: index);
    _audioPlayer.play();
  }

  void addAudio({required AudioModel audio}) {
    if (_currentPlaylist.isNotEmpty) {
      _playlist.insert(0, AudioSource.uri(Uri.parse(audio.url), tag: audio));
      notifyListeners();
    }
  }

  Future<void> deleteAudio({required int audioId}) async {
    if (_currentPlaylist.isNotEmpty) {
      var found = _currentPlaylist.where(
        (element) => element.id == audioId,
      );

      if (found.isNotEmpty) {
        var index = _currentPlaylist.indexOf(found.first);
        _playlist.removeAt(index);
        notifyListeners();
      }
    }
  }

  Future<void> addImage(
      {required ImageModel image, required int audioIndex}) async {
    _currentPlaylist[audioIndex].images.add(image);
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}
