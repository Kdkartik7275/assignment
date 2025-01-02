import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:just_audio/just_audio.dart';

part 'audio_event.dart';
part 'audio_state.dart';

class AudioBloc extends Bloc<AudioEvent, AudioState> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  AudioBloc() : super(AudioInitial()) {
    on<PlayAudio>(_onPlayAudio);
    on<PauseAudio>(_onPauseAudio);
    on<StopAudio>(_onStopAudio);
    on<UpdateProgress>(_onUpdateProgress);

    _audioPlayer.positionStream.listen((position) {
      if (_audioPlayer.playing) {
        add(UpdateProgress(
          position: position,
          duration: _audioPlayer.duration ?? Duration.zero,
        ));
      }
    });
  }

  Future<void> _onPlayAudio(PlayAudio event, Emitter<AudioState> emit) async {
    await _audioPlayer.setAsset(event.songPath);
    _audioPlayer.play();
    emit(AudioPlaying(
      currentSong: event.songPath,
      position: Duration.zero,
      duration: _audioPlayer.duration ?? Duration.zero,
    ));
  }

  void _onPauseAudio(PauseAudio event, Emitter<AudioState> emit) {
    _audioPlayer.pause();
    if (state is AudioPlaying) {
      emit(AudioPaused(
        currentSong: (state as AudioPlaying).currentSong,
        position: _audioPlayer.position,
        duration: _audioPlayer.duration ?? Duration.zero,
      ));
    }
  }

  void _onStopAudio(StopAudio event, Emitter<AudioState> emit) {
    _audioPlayer.stop();
    emit(AudioStopped());
  }

  void _onUpdateProgress(UpdateProgress event, Emitter<AudioState> emit) {
    if (state is AudioPlaying || state is AudioPaused) {
      emit(AudioPlaying(
        currentSong: (state as AudioPlaying).currentSong,
        position: event.position,
        duration: event.duration,
      ));
    }
  }

  @override
  Future<void> close() {
    _audioPlayer.dispose();
    return super.close();
  }
}
