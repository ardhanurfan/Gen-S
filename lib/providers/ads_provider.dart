import 'package:flutter/cupertino.dart';
import 'package:music_player/models/ads_model.dart';
import 'package:music_player/services/ads_services.dart';

class AdsProvider extends ChangeNotifier {
  List<AdsModel> _ads = [];
  List<AdsModel> _defAds = [];
  String _errorMessage = '';

  List<AdsModel> get ads => _ads;
  List<AdsModel> get defAds => _defAds;
  String get errorMessage => _errorMessage;

  Future<void> getAds() async {
    try {
      List<AdsModel> ads = await AdsService().getAds();
      _defAds = ads;
      var len = ads.length;
      List<AdsModel> temp = [];
      for (var i = 0; i < len; i++) {
        for (var j = 0; j < ads[i].frequency; j++) {
          temp.add(ads[i]);
        }
      }
      temp.shuffle();
      _ads = temp;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> addAds({
    required String contentPath,
    required String frequency,
    required String link,
    required String title,
  }) async {
    try {
      AdsModel insAds = await AdsService().addAds(
        contentPath: contentPath,
        frequency: frequency,
        link: link,
        title: title,
      );
      _defAds.add(insAds);
      for (var j = 0; j < insAds.frequency; j++) {
        ads.add(insAds);
      }
      _ads.shuffle();
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
      _ads.removeWhere((element) => element.id == adsId);
      _ads.shuffle();
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
  }) async {
    try {
      AdsModel editedAds = await AdsService().editAds(
        adsId: adsId,
        frequency: frequency,
        link: link,
        title: title,
      );

      int idx = _defAds.indexWhere((element) => element.id == adsId);
      _defAds.removeAt(idx);
      _defAds.insert(idx, editedAds);

      _ads.removeWhere((element) => element.id == adsId);
      for (var j = 0; j < editedAds.frequency; j++) {
        _ads.add(editedAds);
      }
      _ads.shuffle();
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    }
  }
}
