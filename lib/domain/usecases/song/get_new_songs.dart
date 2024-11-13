import 'package:dartz/dartz.dart';
import 'package:spotify_clone/core/usecase/usecase.dart';
import 'package:spotify_clone/domain/repository/song/song.dart';  // Sử dụng interface SongRepository

import '../../../service_locator.dart';

class GetNewSongsUseCase implements Usecase<Either, dynamic> {
  @override
  Future<Either> call({params}) async {
    // Lấy SongRepository từ GetIt thay vì SongRepositoryImpl
    return await sl<SongRepository>().getNewSongs();
  }  
}
