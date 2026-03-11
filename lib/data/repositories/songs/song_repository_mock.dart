// song_repository_mock.dart

import 'package:flutter/widgets.dart';

import '../../../model/songs/song.dart';
import 'song_repository.dart';

class SongRepositoryMock implements SongRepository {
  int _fetchCount = 0;
  final List<Song> _songs = [
    Song(
      id: 's1',
      title: 'Mock Song 1',
      artist: 'Mock Artist',
      duration: const Duration(minutes: 2, seconds: 50),
    ),
    Song(
      id: 's2',
      title: 'Mock Song 2',
      artist: 'Mock Artist',
      duration: const Duration(minutes: 3, seconds: 20),
    ),
    Song(
      id: 's3',
      title: 'Mock Song 3',
      artist: 'Mock Artist',
      duration: const Duration(minutes: 3, seconds: 20),
    ),
    Song(
      id: 's4',
      title: 'Mock Song 4',
      artist: 'Mock Artist',
      duration: const Duration(minutes: 3, seconds: 20),
    ),
    Song(
      id: 's5',
      title: 'Mock Song 5',
      artist: 'Mock Artist',
      duration: const Duration(minutes: 3, seconds: 20),
    ),
  ];

  @override
  Future<List<Song>> fetchSongs() async {
    await Future.delayed(Duration(seconds: 3), () {});
    _fetchCount ++;
    if(_fetchCount % 2 == 0) {
      throw Exception("Failed to fetch song");
    }
    return _songs;
  }

  @override
  Future<Song?> fetchSongById(String id) async {
    // - Simulate a delay of 3 seconds.

    // - After the delay : Find the song of given id in the list of songs and return it

    // - If not found : Throw an error with the message “no song found for id 25 in the database"

    return Future.delayed(Duration(seconds: 3), () async {
      try {
        final songs = await fetchSongs();
        Song result = songs.firstWhere((song) => song.id == id);
        return result;
      } catch (e) {
        throw Exception("no song found for id $id in the database");
      }
    }); // TO CHANGE !
  }

  // TO CHANGE !
}
