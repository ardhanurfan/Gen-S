import 'package:equatable/equatable.dart';

import 'image_model.dart';

class GalleryModel extends Equatable {
  final int id;
  final String name;
  final List<ImageModel> images;

  const GalleryModel({
    required this.id,
    required this.name,
    required this.images,
  });

  factory GalleryModel.fromJson(Map<String, dynamic> json) {
    return GalleryModel(
      id: json['id'],
      name: json['name'],
      images: List<ImageModel>.from(
        json['images'].map((x) => ImageModel.fromJson(x)),
      ),
    );
  }

  @override
  List<Object?> get props => [id, name, images];
}
