import 'package:flutter/cupertino.dart';
import 'package:music_player/models/gallery_model.dart';
import 'package:music_player/services/gallery_service.dart';
import 'package:music_player/services/image_service.dart';

import '../models/image_model.dart';

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

  Future<bool> addImageGallery(
      {required String imagePath, required int galleryId}) async {
    try {
      ImageModel newImage = await ImageService()
          .addImage(galleryId: galleryId, imagePath: imagePath);
      _galleries
          .firstWhere(
            (element) => element.id == galleryId,
          )
          .images
          .add(newImage);
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    }
  }

  Future<bool> deleteImageGallery(
      {required List<ImageModel> imagesDel, required int galleryId}) async {
    try {
      for (var image in imagesDel) {
        _galleries
            .firstWhere(
              (element) => element.id == galleryId,
            )
            .images
            .remove(image);
        await ImageService().deleteImage(imageId: image.id);
        notifyListeners();
      }
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    }
  }

  void addImageGalleryFromAudio({required ImageModel image}) {
    _galleries
        .firstWhere((element) => element.name == 'root')
        .images
        .add(image);
    notifyListeners();
  }

  void deleteImageGalleryFromAudio({required ImageModel image}) {
    var root = _galleries.where((element) => element.name == 'root').first;
    if (root.images.contains(image)) {
      root.images.remove(image);
      notifyListeners();
    }
  }
}
