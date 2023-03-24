import 'package:equatable/equatable.dart';

class AdsModel extends Equatable {
  final int id;
  final String title;
  final DateTime uploadTime;
  final int frequency;
  final String url;

  const AdsModel({
    required this.id,
    required this.title,
    required this.uploadTime,
    required this.frequency,
    required this.url,
  });

  factory AdsModel.fromJson(Map<String, dynamic> json) {
    return AdsModel(
      id: json['id'],
      title: json['title'],
      uploadTime: DateTime.parse(json['upload_time']),
      frequency: json['frequency'],
      url: json['url'],
    );
  }

  @override
  List<Object?> get props => [id, title, uploadTime, url, frequency];
}
