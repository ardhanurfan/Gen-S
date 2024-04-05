import 'package:flutter/cupertino.dart';
import 'package:music_player/models/gallery_model.dart';
import 'package:music_player/services/gallery_service.dart';
import 'package:music_player/services/image_service.dart';

import '../models/image_model.dart';

class GalleryProvider extends ChangeNotifier {
  List<GalleryModel> _galleries = [];
  List<GalleryModel> _allGalleries = [];
  String _errorMessage = '';

  List<GalleryModel> get galleries => _galleries;
  List<GalleryModel> get allGalleries => _allGalleries;
  String get errorMessage => _errorMessage;

  Future<void> getGallery() async {
    try {
      List<GalleryModel> galleries = await GalleryService().getGalleries();
      _galleries = galleries;
      for (var gallery in _galleries) {
        _allGalleries.addAll(gallery.flatten());
      }
      _allGalleries.sort((a, b) => a.name.compareTo(b.name));
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> addGallery({required String name, required int parentId}) async {
    try {
      GalleryModel gallery =
          await GalleryService().addGallery(name: name, parentId: parentId);
      _allGalleries.add(gallery);
      _allGalleries.sort((a, b) => a.name.compareTo(b.name));
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    }
  }

  Future<bool> deleteGallery(
      {required int galleryId, required int parrentId}) async {
    try {
      await GalleryService().deleteGallery(galleryId: galleryId);
      var index = _allGalleries.indexOf(
        _allGalleries.firstWhere(
          (element) => element.id == galleryId,
        ),
      );
      List<GalleryModel> currentAndChildren = [];
      for (var child in _allGalleries[index].children) {
        currentAndChildren.addAll(child.flatten());
      }
      for (var gallery in currentAndChildren) {
        await GalleryService().deleteGallery(galleryId: gallery.id);
        _allGalleries.remove(gallery);
      }
      _allGalleries.removeAt(index);
      notifyListeners();

      return true;
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    }
  }

  Future<bool> addImageGallery(
      {required String imagePath,
      required int galleryId,
      required String title}) async {
    try {
      ImageModel newImage = await ImageService()
          .addImage(galleryId: galleryId, imagePath: imagePath, title: title);
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

  Future<bool> renameGallery(
      {required String name, required int galleryId}) async {
    try {
      GalleryModel newPlaylist =
          await GalleryService().rename(name: name, galleryId: galleryId);
      var index = _allGalleries.indexOf(
        _allGalleries.firstWhere(
          (element) => element.id == galleryId,
        ),
      );
      _allGalleries.removeAt(index);
      _allGalleries.insert(index, newPlaylist);
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    }
  }
}
