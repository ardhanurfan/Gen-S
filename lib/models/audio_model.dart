import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

import 'image_model.dart';

class AudioModel extends Equatable {
  final int id;
  final String title;
  final String url;
  final int uploaderId;
  final DateTime createdAt;
  final List<ImageModel> images;

  const AudioModel({
    required this.id,
    required this.title,
    required this.url,
    required this.uploaderId,
    required this.createdAt,
    required this.images,
  });

  factory AudioModel.fromJson(Map<String, dynamic> json) {
    return AudioModel(
      id: json['id'],
      title: json['title'],
      url: json['url'],
      uploaderId: json['uploaderId'],
      createdAt: DateTime.parse(json['created_at']),
      images: List<ImageModel>.from(
        json['images'].map((x) => ImageModel.fromJson(x)),
      ),
    );
  }

  toJson() {
    return {
      'id': id,
      'title': title,
      'url': url,
      'uploaderId': uploaderId,
      'created_at': createdAt.toString(),
      'images': List<Map<String, dynamic>>.from(
        images.map((x) => x.toJson()),
      ),
    };
  }

  @override
  List<Object?> get props => [id, title, url, uploaderId, createdAt, images];
}
