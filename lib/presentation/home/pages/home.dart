import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify_clone/common/helpers/is_dark_mode.dart';
import 'package:spotify_clone/common/widgets/appbar/app_bar.dart';
import 'package:spotify_clone/core/configs/assets/app_images.dart';
import 'package:spotify_clone/core/configs/assets/app_vectors.dart';
import 'package:spotify_clone/core/configs/theme/app_colors.dart';
import 'package:spotify_clone/presentation/home/widgets/new_songs.dart';
import 'package:spotify_clone/presentation/home/widgets/playlist.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  @override
  void initState() {
    super.initState();
    _controller = new TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppbar(
        title: SvgPicture.asset(
          AppVectors.logo,
          height: 40,
          width: 40,
        ),
        hideBack: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _homeTopCard(),
            _homeTopTabs(),
            SizedBox(
              height: 260,
              child: TabBarView(
                controller: _controller,
                children: [
                NewSongs(),
                Container(),
                Container(),
                Container(),
              ]),
            ),
            const SizedBox(height: 40,),
            const Playlist()
          ],
        ),
      ),
    );
  }

  Widget _homeTopCard() {
    return Center(
      child: SizedBox(
          height: 140,
          child: Stack(children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: SvgPicture.asset(
                AppVectors.homeTopCard,
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 60),
                child: Image.asset(AppImages.homeArtist),
              ),
            )
          ])),
    );
  }

  Widget _homeTopTabs() {
    return TabBar(
      tabAlignment: TabAlignment.center,
      controller: _controller,
      labelColor: context.IsDarkMode ? Colors.white : Colors.black,
      indicatorColor: AppColors.primary,
      isScrollable: true,
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 16),
      tabs: const [
        Text("News",
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
        Text("Videos",
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
        Text("Artists",
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
        Text("Podcasts",
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
      ],
    );
  }
}
