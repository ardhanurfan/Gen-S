import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:music_player/models/audio_model.dart';
import 'package:music_player/models/image_model.dart';
import 'package:music_player/services/audio_service.dart';
import 'package:music_player/services/image_service.dart';
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
  AudioModel? get currAudio => _currAudio;

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

  Future<bool> updateHistory({required AudioModel audio}) async {
    try {
      if (_currAudio == null || _currAudio!.id != audio.id) {
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
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> audioPicker() async {
    try {
      var result = await FilePicker.platform
          .pickFiles(type: FileType.custom, allowedExtensions: ['mp3', 'm4a']);
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
      (a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()),
    );
    notifyListeners();
  }

  void sortDescending() {
    _audios.sort(
      (a, b) => b.title.toLowerCase().compareTo(a.title.toLowerCase()),
    );
    notifyListeners();
  }

  Future<bool> addImageAudio(
      {required String imagePath, required int audioId}) async {
    try {
      ImageModel newImage =
          await ImageService().addImage(audioId: audioId, imagePath: imagePath);

      _currAudio!.images.add(newImage);
      notifyListeners();

      // kalau sudah diplay otomatis ada di history
      _historyMosts
          .firstWhere((element) => element.id == audioId)
          .images
          .add(newImage);

      _historyRecents
          .firstWhere((element) => element.id == audioId)
          .images
          .add(newImage);

      return true;
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    }
  }

  Future<bool> deleteImageAudio(
      {required int imageId, required int audioId}) async {
    try {
      await ImageService().deleteImage(imageId: imageId);

      _currAudio!.images.removeWhere((element) => element.id == imageId);

      _audios
          .firstWhere((element) => element.id == audioId)
          .images
          .removeWhere((element) => element.id == imageId);

      // kalau sudah diplay otomatis ada di history
      _historyMosts
          .firstWhere((element) => element.id == audioId)
          .images
          .removeWhere((element) => element.id == imageId);

      _historyRecents
          .firstWhere((element) => element.id == audioId)
          .images
          .removeWhere((element) => element.id == imageId);
      notifyListeners();

      return true;
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    }
  }

  void deleteImageFromGallery({required List<ImageModel> imagesDel}) {
    for (var image in imagesDel) {
      var currFound = _currAudio!.images.contains(image);
      if (currFound) {
        _currAudio!.images.remove(image);
      }

      var found = _audios.where((element) => element.images.contains(image));
      if (found.isNotEmpty) {
        int audioId = found.first.id;
        _audios
            .firstWhere(
              (element) => element.id == audioId,
            )
            .images
            .remove(image);
      }

      var foundMost =
          _historyMosts.where((element) => element.images.contains(image));
      if (foundMost.isNotEmpty) {
        int audioId = foundMost.first.id;
        _historyMosts
            .firstWhere(
              (element) => element.id == audioId,
            )
            .images
            .remove(image);
      }

      var foundRecent =
          _historyRecents.where((element) => element.images.contains(image));
      if (foundRecent.isNotEmpty) {
        int audioId = foundRecent.first.id;
        _historyRecents
            .firstWhere(
              (element) => element.id == audioId,
            )
            .images
            .remove(image);
      }

      notifyListeners();
    }
  }

  Future<bool> renameAudio(
      {required String title, required int audioId}) async {
    try {
      AudioModel newAudio =
          await AudioService().rename(title: title, audioId: audioId);

      if (currAudio != null && currAudio!.id == audioId) {
        _currAudio = newAudio;
      }

      // update in audios
      var indexAudios = _audios.indexOf(
        _audios.firstWhere(
          (element) => element.id == audioId,
        ),
      );
      _audios.removeAt(indexAudios);
      _audios.insert(indexAudios, newAudio);

      // update in most
      if (_historyMosts.where((element) => element.id == audioId).isNotEmpty) {
        var indexMost = _historyMosts.indexOf(
          _historyMosts.firstWhere(
            (element) => element.id == audioId,
          ),
        );
        if (indexMost != -1) {
          _historyMosts.removeAt(indexMost);
          _historyMosts.insert(indexMost, newAudio);
        }
      }

      // update in recent
      if (_historyRecents
          .where((element) => element.id == audioId)
          .isNotEmpty) {
        var indexRecent = _historyRecents.indexOf(
          _historyRecents.firstWhere(
            (element) => element.id == audioId,
          ),
        );
        if (indexRecent != -1) {
          _historyRecents.removeAt(indexRecent);
          _historyRecents.insert(indexRecent, newAudio);
        }
      }
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    }
  }
}
