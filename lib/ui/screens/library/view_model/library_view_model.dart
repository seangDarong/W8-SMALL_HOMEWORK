import 'package:flutter/material.dart';
import '../../../../data/repositories/songs/song_repository.dart';
import '../../../states/player_state.dart';
import '../../../../model/songs/song.dart';

class LibraryViewModel extends ChangeNotifier {
  final SongRepository songRepository;
  final PlayerState playerState;
  // List<Song>? _songs;
  AsyncValue<List<Song>> _songs = const AsyncLoading();

  LibraryViewModel({required this.songRepository, required this.playerState}) {
    playerState.addListener(notifyListeners);

    // init
    _init();
  }

  // List<Song> get songs => _songs == null ? [] : _songs!;
  AsyncValue<List<Song>> get songs => _songs;

  @override
  void dispose() {
    playerState.removeListener(notifyListeners);
    super.dispose();
  }

  void _init() async {
    // 1 - Fetch songs
    // _songs = await songRepository.fetchSongs();
    _songs = const AsyncLoading();

    // 2 - notify listeners
    notifyListeners();

    try{
      final data = await songRepository.fetchSongs();
      _songs = AsyncData(data);
    }catch (e){
      _songs = AsyncError(e);
    }
    notifyListeners();
  }

  bool isSongPlaying(Song song) => playerState.currentSong == song;

  void start(Song song) => playerState.start(song);
  void stop(Song song) => playerState.stop();
}

sealed class AsyncValue<T> {
  const AsyncValue();
}

class AsyncLoading<T> extends AsyncValue<T> {
  const AsyncLoading();
}

class AsyncData<T> extends AsyncValue<T> {
  final T value;
  const AsyncData(this.value);
}

class AsyncError<T> extends AsyncValue<T> {
  final Object error;
  const AsyncError(this.error);
}