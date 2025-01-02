part of 'audio_bloc.dart';

abstract class AudioEvent extends Equatable {
  const AudioEvent();

  @override
  List<Object> get props => [];
}

class PlayAudio extends AudioEvent {
  final String songPath;

  const PlayAudio({required this.songPath});

  @override
  List<Object> get props => [songPath];
}

class PauseAudio extends AudioEvent {}

class StopAudio extends AudioEvent {}

class UpdateProgress extends AudioEvent {
  final Duration position;
  final Duration duration;

  const UpdateProgress({required this.position, required this.duration});
}
