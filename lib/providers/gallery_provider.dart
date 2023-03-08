import 'package:flutter/cupertino.dart';
import 'package:music_player/models/gallery_model.dart';
import 'package:music_player/services/gallery_service.dart';

class GalleryProvider extends ChangeNotifier {
  List<GalleryModel> _galleries = [];

  List<GalleryModel> get galleries => _galleries;

  Future<void> getGallery() async {
    try {
      List<GalleryModel> galleries = await GalleryService().getGalleries();
      _galleries = galleries;
    } catch (e) {
      rethrow;
    }
  }
}
