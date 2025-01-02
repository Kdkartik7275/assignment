part of 'audio_bloc.dart';

abstract class AudioState extends Equatable {
  const AudioState();

  @override
  List<Object> get props => [];
}

class AudioInitial extends AudioState {}

class AudioPlaying extends AudioState {
  final String currentSong;
  final Duration position;
  final Duration duration;

  const AudioPlaying(
      {required this.currentSong,
      required this.position,
      required this.duration});

  @override
  List<Object> get props => [currentSong, position, duration];
}

class AudioPaused extends AudioState {
  final String currentSong;
  final Duration position;
  final Duration duration;

  const AudioPaused(
      {required this.currentSong,
      required this.position,
      required this.duration});

  @override
  List<Object> get props => [currentSong, position, duration];
}

class AudioStopped extends AudioState {}
