import 'package:flutter/cupertino.dart';
import 'package:music_player/models/gallery_model.dart';
import 'package:music_player/services/gallery_service.dart';

class GalleryProvider extends ChangeNotifier {
  List<GalleryModel> _galleries = [];
  String _errorMessage = '';

  List<GalleryModel> get galleries => _galleries;
  String get errorMessage => _errorMessage;

  Future<void> getGallery() async {
    try {
      List<GalleryModel> galleries = await GalleryService().getGalleries();
      _galleries = galleries;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> addGallery({required String name}) async {
    try {
      _galleries.add(await GalleryService().addGallery(name: name));
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    }
  }

  Future<bool> deleteGallery({required int galleryId}) async {
    try {
      await GalleryService().deleteGallery(galleryId: galleryId);
      var index = _galleries.indexOf(
        _galleries.firstWhere(
          (element) => element.id == galleryId,
        ),
      );
      _galleries.removeAt(index);
      notifyListeners();

      return true;
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    }
  }
}
