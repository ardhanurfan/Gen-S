import 'package:equatable/equatable.dart';

import 'image_model.dart';

class AudioModel extends Equatable {
  final int id;
  final String title;
  final String url;
  final int uploaderId;
  final List<ImageModel> images;

  const AudioModel({
    required this.id,
    required this.title,
    required this.url,
    required this.uploaderId,
    required this.images,
  });

  factory AudioModel.fromJson(Map<String, dynamic> json) {
    return AudioModel(
      id: json['id'],
      title: json['title'],
      url: json['url'],
      uploaderId: json['uploaderId'],
      images: List<ImageModel>.from(
        json['images'].map((x) => ImageModel.fromJson(x)),
      ),
    );
  }

  @override
  List<Object?> get props => [id, title, url, images];
}
