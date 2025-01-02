import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internship_assignment/features/audioplayers/presentation/bloc/audio_bloc.dart';

class AudioPlayerPage extends StatelessWidget {
  final List<Map<String, String>> songs = [
    {
      'title': 'Agar Ho Tum',
      'artist': 'Jubin Nautiyal',
      'cover': 'assets/images/tum.jpg',
      'path': 'assets/audio/song1.mp3',
    },
    {
      'title': 'Kissak',
      'artist': 'Ryan Grigory',
      'cover': 'assets/images/kissak.png',
      'path': 'assets/audio/song2.mp3',
    },
    {
      'title': 'Dream On',
      'artist': 'Roger Terry',
      'cover': 'assets/images/flag.jpg',
      'path': 'assets/audio/song3.mp3',
    },
    {
      'title': 'Origins',
      'artist': 'Imagine Dragons',
      'cover': 'assets/images/flag.jpg',
      'path': 'assets/audio/song4.mp3',
    },
  ];

  AudioPlayerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1D1E33), Color(0xFF111328)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            Expanded(child: _buildSongGrid(context)),
            _buildPlayerControls(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSongGrid(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: songs.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.75,
      ),
      itemBuilder: (context, index) {
        final song = songs[index];
        return _buildSongCard(context, song);
      },
    );
  }

  Widget _buildSongCard(BuildContext context, Map<String, String> song) {
    return GestureDetector(
      onTap: () {
        context.read<AudioBloc>().add(PlayAudio(songPath: song['path']!));
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black45,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.asset(
                  song['cover']!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 8),
            _buildSongInfo(song),
          ],
        ),
      ),
    );
  }

  Widget _buildSongInfo(Map<String, String> song) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            song['title']!,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            song['artist']!,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildPlayerControls(BuildContext context) {
    return BlocBuilder<AudioBloc, AudioState>(
      builder: (context, state) {
        if (state is AudioPlaying || state is AudioPaused) {
          final song = songs.firstWhere(
            (song) => song['path'] == (state as dynamic).currentSong,
            orElse: () => songs[0],
          );
          final position = state is AudioPlaying
              ? state.position
              : (state as AudioPaused).position;
          final duration = state is AudioPlaying
              ? state.duration
              : (state as AudioPaused).duration;

          return _buildNowPlayingPanel(
              context, song, position, duration, state);
        } else {
          return const SizedBox();
        }
      },
    );
  }

  Widget _buildNowPlayingPanel(BuildContext context, Map<String, String> song,
      Duration position, Duration duration, AudioState state) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF292B4E), Color(0xFF111328)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              _buildSongCover(song),
              const SizedBox(width: 16),
              _buildSongDetails(song),
              _buildPlayPauseButton(state, context),
              _buildStopButton(context),
            ],
          ),
          _buildSlider(position, duration, context),
        ],
      ),
    );
  }

  Widget _buildSongCover(Map<String, String> song) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: Image.asset(
        song['cover']!,
        height: 50,
        width: 50,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildSongDetails(Map<String, String> song) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            song['title']!,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            song['artist']!,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlayPauseButton(AudioState state, BuildContext context) {
    return IconButton(
      icon: Icon(
        state is AudioPlaying
            ? Icons.pause_circle_filled
            : Icons.play_circle_filled,
        color: Colors.white,
        size: 36,
      ),
      onPressed: () {
        if (state is AudioPlaying) {
          context.read<AudioBloc>().add(PauseAudio());
        } else {
          context
              .read<AudioBloc>()
              .add(PlayAudio(songPath: (state as dynamic).currentSong));
        }
      },
    );
  }

  Widget _buildStopButton(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.stop, color: Colors.white),
      onPressed: () {
        context.read<AudioBloc>().add(StopAudio());
      },
    );
  }

  Widget _buildSlider(
      Duration position, Duration duration, BuildContext context) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        activeTrackColor: Colors.white,
        inactiveTrackColor: Colors.grey,
        thumbColor: Colors.white,
        thumbShape: const RoundSliderThumbShape(
          enabledThumbRadius: 8.0,
        ),
      ),
      child: Slider(
        value: position.inSeconds.toDouble(),
        max: duration.inSeconds.toDouble(),
        onChanged: (value) {},
      ),
    );
  }
}
