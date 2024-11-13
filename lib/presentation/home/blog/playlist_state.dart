import 'package:spotify_clone/domain/entities/song/song.dart';

abstract class PlaylistState {

}

class PlaylistLoading extends PlaylistState {
  
}

class PlaylistLoaded extends PlaylistState {
   final List<SongEntity> songs;

  PlaylistLoaded({required this.songs});
}

class PlaylistLoadingFalse extends PlaylistState {

}