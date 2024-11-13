import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone/domain/usecases/song/get_new_songs.dart';
import 'package:spotify_clone/presentation/home/blog/new_songs_state.dart';

import '../../../service_locator.dart';

class NewSongsCubit extends Cubit<NewSongsState>{
  NewSongsCubit() : super(NewSongsLoading());
  
  Future<void> getNewSongs() async {
    var returnSongs = await sl<GetNewSongsUseCase>().call();

    returnSongs.fold(
      (l){
        emit(NewSongsLoadingFalse());
      },
      (data){
        emit(NewSongsLoaded(songs: data));
      }
    );
  }
}