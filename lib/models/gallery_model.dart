import 'package:equatable/equatable.dart';

import 'image_model.dart';

class GalleryModel extends Equatable {
  final int id;
  final String name;
  final List<ImageModel> images;
  final int parentId;
  final List<GalleryModel> children;

  const GalleryModel({
    required this.id,
    required this.name,
    required this.images,
    required this.parentId,
    required this.children,
  });

  factory GalleryModel.fromJson(Map<String, dynamic> json) {
    return GalleryModel(
        id: json['id'],
        parentId: json['parentId'] ?? 0,
        name: json['name'],
        images: List<ImageModel>.from(
          json['images'].map((x) => ImageModel.fromJson(x)),
        ),
        children: json['children'] != null
            ? List<GalleryModel>.from(
                json['children'].map((x) => GalleryModel.fromJson(x)),
              )
            : []);
  }

  List<GalleryModel> flatten() {
    List<GalleryModel> result = [];
    result.add(this);
    for (var child in children) {
      result.addAll(child.flatten());
    }
    return result;
  }

  @override
  List<Object?> get props => [id, name, images, parentId, children];
}
