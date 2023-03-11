import 'package:equatable/equatable.dart';

class PositionDataModel extends Equatable {
  const PositionDataModel(
    this.position,
    this.bufferedPosition,
    this.duration,
  );

  final Duration position;
  final Duration bufferedPosition;
  final Duration duration;

  @override
  List<Object?> get props => [position, bufferedPosition, duration];
}
