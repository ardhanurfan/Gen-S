import 'package:equatable/equatable.dart';

class ImageModel extends Equatable {
  final int id;
  final String url;

  const ImageModel({
    required this.id,
    required this.url,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      id: json['id'],
      url: json['url'],
    );
  }

  @override
  List<Object?> get props => [url, id];
}
