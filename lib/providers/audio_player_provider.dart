import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:music_player/models/image_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/audio_model.dart';

class AudioPlayerProvider extends ChangeNotifier {
  late AudioPlayer _audioPlayer;
  late ConcatenatingAudioSource _playlist;
  List<AudioModel> _currentPlaylist = [];

  AudioPlayer get audioPlayer => _audioPlayer;
  ConcatenatingAudioSource get playlist => _playlist;
  List<AudioModel> get currentPlaylist => _currentPlaylist;

  Future<void> init() async {
    final pref = await SharedPreferences.getInstance();
    _audioPlayer = AudioPlayer();

    bool? shuffle = pref.getBool('shuffle');
    if (shuffle != null) {
      await _audioPlayer.setShuffleModeEnabled(shuffle);
    } else {
      await _audioPlayer.setShuffleModeEnabled(false);
      await pref.setBool('shuffle', false);
    }

    String? loop = pref.getString('loop');
    if (loop != null) {
      if (loop == 'one') {
        await _audioPlayer.setLoopMode(LoopMode.one);
      } else if (loop == 'off') {
        await _audioPlayer.setLoopMode(LoopMode.off);
      } else {
        await _audioPlayer.setLoopMode(LoopMode.all);
      }
    } else {
      await _audioPlayer.setLoopMode(LoopMode.all);
      await pref.setString('loop', 'all');
    }
  }

  Future<void> setPlay(List<AudioModel> playlist, int index) async {
    _playlist = ConcatenatingAudioSource(
      children: playlist
          .map(
            (audio) => AudioSource.uri(
              Uri.parse(audio.url),
              tag: MediaItem(
                id: audio.id.toString(),
                title: audio.title,
                artUri: audio.images.isEmpty
                    ? null
                    : Uri.parse(audio.images[0].url),
                extras: AudioModel(
                  id: audio.id,
                  title: audio.title,
                  url: audio.url,
                  uploaderId: audio.uploaderId,
                  createdAt: audio.createdAt,
                  images: audio.images,
                ).toJson(),
              ),
            ),
          )
          .toList(),
    );
    _currentPlaylist = playlist;
    await _audioPlayer.setAudioSource(_playlist, initialIndex: index);

    await _audioPlayer.seek(const Duration(seconds: 0), index: index);
    _audioPlayer.play();
  }

  void addAudio({required AudioModel audio, isPlaylist = false}) {
    if (_currentPlaylist.isNotEmpty) {
      if (isPlaylist) {
        _playlist.add(
          AudioSource.uri(
            Uri.parse(audio.url),
            tag: MediaItem(
              id: audio.id.toString(),
              title: audio.title,
              artUri:
                  audio.images.isEmpty ? null : Uri.parse(audio.images[0].url),
              extras: audio.toJson(),
            ),
          ),
        );
      } else {
        _playlist.insert(
          0,
          AudioSource.uri(
            Uri.parse(audio.url),
            tag: MediaItem(
              id: audio.id.toString(),
              title: audio.title,
              artUri:
                  audio.images.isEmpty ? null : Uri.parse(audio.images[0].url),
              extras: audio.toJson(),
            ),
          ),
        );
      }
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
