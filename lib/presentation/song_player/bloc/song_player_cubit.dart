import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:spotify_clone/presentation/song_player/bloc/song_player_state.dart';

class SongPlayerCubit extends Cubit<SongPlayerState> {
  final AudioPlayer audioPlayer = AudioPlayer();

  Duration songDuration = Duration.zero;
  Duration songPosition = Duration.zero;

  SongPlayerCubit() : super(SongPlayerLoading()) {
    // Lắng nghe vị trí hiện tại của bài hát
    audioPlayer.positionStream.listen((position) {
      songPosition = position;
      updateSongPlayerPosition();
    });

    // Lắng nghe độ dài của bài hát
    audioPlayer.durationStream.listen((duration) {
      if (duration != null) {
        songDuration = duration;
        emit(SongPlayerLoaded());
      }
    });
  }

  void updateSongPlayerPosition() {
    emit(SongPlayerLoaded());
  }

  Future<void> loadSong(String url) async {
    try {
      emit(SongPlayerLoading()); // Trạng thái loading
      await audioPlayer.setUrl(url);
      emit(SongPlayerLoaded()); // Trạng thái loaded sau khi load xong bài hát
    } catch (e) {
      emit(SongPlayerFailure()); // Trạng thái failure khi có lỗi
    }
  }

  Future<void> playOrPause() async {
    if (audioPlayer.playing) {
      await audioPlayer.pause();
    } else {
      await audioPlayer.play();
    }
    emit(SongPlayerLoaded());
  }

  @override
  Future<void> close() {
    audioPlayer.dispose();
    return super.close();
  }
}

