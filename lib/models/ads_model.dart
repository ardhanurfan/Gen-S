import 'package:equatable/equatable.dart';

class AdsModel extends Equatable {
  final int id;
  final DateTime uploadTime;
  final int frequency;
  final String url;
  final String link;
  final String title;

  const AdsModel({
    required this.id,
    required this.uploadTime,
    required this.frequency,
    required this.url,
    required this.link,
    required this.title,
  });

  factory AdsModel.fromJson(Map<String, dynamic> json) {
    return AdsModel(
      id: json['id'],
      uploadTime: DateTime.parse(json['created_at']),
      frequency: json['frequency'],
      url: json['url'],
      link: json['link'],
      title: json['title'],
    );
  }

  @override
  List<Object?> get props => [id, uploadTime, url, frequency, link, title];
}
