import 'package:equatable/equatable.dart';
import 'package:music_player/models/audio_model.dart';

class PlaylistModel extends Equatable {
  final int id;
  final String name;
  final List<AudioModel> audios;

  const PlaylistModel({
    required this.id,
    required this.name,
    required this.audios,
  });

  factory PlaylistModel.fromJson(Map<String, dynamic> json) {
    return PlaylistModel(
      id: json['id'],
      name: json['name'],
      audios: List<AudioModel>.from(
        json['audios'].map((x) => AudioModel.fromJson(x)),
      ),
    );
  }

  @override
  List<Object?> get props => [id, name, audios];
}
