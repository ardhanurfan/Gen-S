import 'package:equatable/equatable.dart';

class AdsModel extends Equatable {
  final int id;
  final String title;
  final DateTime uploadTime;
  final int frequency;
  final String url;
  final String link;

  const AdsModel({
    required this.id,
    required this.title,
    required this.uploadTime,
    required this.frequency,
    required this.url,
    required this.link,
  });

  factory AdsModel.fromJson(Map<String, dynamic> json) {
    return AdsModel(
      id: json['id'],
      title: json['title'],
      uploadTime: DateTime.parse(json['upload_time']),
      frequency: json['frequency'],
      url: json['url'],
      link: json['link'],
    );
  }

  @override
  List<Object?> get props => [id, title, uploadTime, url, frequency];
}
