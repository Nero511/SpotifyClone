import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone/common/helpers/is_dark_mode.dart';
import 'package:spotify_clone/core/configs/constants/app_urls.dart';
import 'package:spotify_clone/core/configs/theme/app_colors.dart';
import 'package:spotify_clone/domain/entities/song/song.dart';
import 'package:spotify_clone/presentation/home/blog/new_songs_cubit.dart';
import 'package:spotify_clone/presentation/home/blog/new_songs_state.dart';

class NewSongs extends StatelessWidget {
  const NewSongs({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NewSongsCubit()..getNewSongs(),
      child: SizedBox(
          height: 200,
          child: BlocBuilder<NewSongsCubit, NewSongsState>(
            builder: (context, state) {
              if (state is NewSongsLoading)
                return Container(
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator());
              if (state is NewSongsLoaded) {
                return _songs(state.songs);
              }
              return Container();
            },
          )),
    );
  }

  Widget _songs(List<SongEntity> songs) {
    return SizedBox(
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return SizedBox(
            width: 120,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height:
                      160, // Đặt chiều cao cố định cho Container thay vì dùng Expanded
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        '${AppUrls.firestorage}${songs[index].title}.jpg?${AppUrls.mediaAlt}',
                      ),
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      height: 40,
                      width: 40,
                      transform: Matrix4.translationValues(10, 10, 0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: context.IsDarkMode
                            ? AppColors.darkGrey
                            : const Color(0xffE6E6E6),
                      ),
                      child: Icon(
                        Icons.play_arrow_rounded,
                        color: context.IsDarkMode
                            ? const Color(0xff959595)
                            : const Color(0xff555555),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  songs[index].title,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  songs[index].artist,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(
            width: 14, // Điều chỉnh khoảng cách giữa các ảnh
          );
        },
        itemCount: songs.length,
      ),
    );
  }
}
