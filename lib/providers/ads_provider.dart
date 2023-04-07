import 'package:flutter/cupertino.dart';
import 'package:music_player/models/ads_model.dart';
import 'package:music_player/services/ads_services.dart';

class AdsProvider extends ChangeNotifier {
  List<AdsModel> _adsBottom = [];
  List<AdsModel> _adsPlayer = [];
  List<AdsModel> _defAds = [];
  String _errorMessage = '';

  List<AdsModel> get adsBottom => _adsBottom;
  List<AdsModel> get adsPlayer => _adsPlayer;
  List<AdsModel> get defAds => _defAds;
  String get errorMessage => _errorMessage;

  Future<void> getAds() async {
    try {
      List<AdsModel> adsBottom = await AdsService().getAds(location: 'bottom');
      List<AdsModel> adsPlayer = await AdsService().getAds(location: 'player');
      _defAds = adsBottom + adsPlayer;
      _defAds.sort((a, b) => a.id.compareTo(b.id));

      // add bottom
      List<AdsModel> tempBottom = [];
      for (var i = 0; i < adsBottom.length; i++) {
        for (var j = 0; j < adsBottom[i].frequency; j++) {
          tempBottom.add(adsBottom[i]);
        }
      }
      tempBottom.shuffle();
      _adsBottom = tempBottom;

      // add player
      List<AdsModel> tempPlayer = [];
      for (var i = 0; i < adsPlayer.length; i++) {
        for (var j = 0; j < adsPlayer[i].frequency; j++) {
          tempPlayer.add(adsPlayer[i]);
        }
      }
      tempPlayer.shuffle();
      _adsPlayer = tempPlayer;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> addAds({
    required String contentPath,
    required String frequency,
    required String link,
    required String title,
    required String location,
  }) async {
    try {
      AdsModel insAds = await AdsService().addAds(
        contentPath: contentPath,
        frequency: frequency,
        link: link,
        title: title,
        location: location,
      );
      _defAds.add(insAds);

      if (location == 'bottom') {
        for (var j = 0; j < insAds.frequency; j++) {
          _adsBottom.add(insAds);
        }
        _adsBottom.shuffle();
      }

      if (location == 'player') {
        for (var j = 0; j < insAds.frequency; j++) {
          _adsPlayer.add(insAds);
        }
        _adsPlayer.shuffle();
      }

      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    }
  }

  Future<bool> deleteAds({
    required int adsId,
  }) async {
    try {
      await AdsService().deleteAds(adsId: adsId);
      _defAds.removeWhere((element) => element.id == adsId);

      bool bottomFound =
          _adsBottom.where((element) => element.id == adsId).isNotEmpty;
      if (bottomFound) {
        _adsBottom.removeWhere((element) => element.id == adsId);
        _adsBottom.shuffle();
      } else {
        _adsPlayer.removeWhere((element) => element.id == adsId);
        _adsPlayer.shuffle();
      }

      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    }
  }

  Future<bool> editAds({
    required int adsId,
    required String frequency,
    required String link,
    required String title,
    required String location,
  }) async {
    try {
      AdsModel editedAds = await AdsService().editAds(
        adsId: adsId,
        frequency: frequency,
        link: link,
        title: title,
        location: location,
      );

      int idx = _defAds.indexWhere((element) => element.id == adsId);
      _defAds.removeAt(idx);
      _defAds.insert(idx, editedAds);

      bool bottomFound =
          _adsBottom.where((element) => element.id == adsId).isNotEmpty;
      if (bottomFound) {
        _adsBottom.removeWhere((element) => element.id == adsId);
        for (var j = 0; j < editedAds.frequency; j++) {
          _adsBottom.add(editedAds);
        }
        _adsBottom.shuffle();
      } else {
        _adsPlayer.removeWhere((element) => element.id == adsId);
        for (var j = 0; j < editedAds.frequency; j++) {
          _adsPlayer.add(editedAds);
        }
        _adsPlayer.shuffle();
      }

      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    }
  }
}
