import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone/domain/usecases/song/get_playlist.dart';
import 'package:spotify_clone/presentation/home/blog/playlist_state.dart';

import '../../../service_locator.dart';

class PlaylistCubit extends Cubit<PlaylistState>{
  PlaylistCubit() : super(PlaylistLoading());
  
  Future<void> getPlaylist() async {
    var returnSongs = await sl<GetPlaylistUseCase>().call();

    returnSongs.fold(
      (l){
        emit(PlaylistLoadingFalse());
      },
      (data){
        emit(PlaylistLoaded(songs: data));
      }
    );
  }
}