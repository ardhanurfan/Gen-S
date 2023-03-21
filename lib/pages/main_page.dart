import 'package:flutter/material.dart';
import 'package:music_player/pages/gallery/gallery_page.dart';
import 'package:music_player/pages/playlist/playlist_page.dart';
import 'package:music_player/pages/search_page.dart';
import 'package:music_player/providers/page_provider.dart';
import 'package:music_player/widgets/playing_tile.dart';
import 'package:provider/provider.dart';

import '../../shared/theme.dart';
import 'home/home_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    PageProvider pageProvider = Provider.of<PageProvider>(context);

    Widget buildContent() {
      int newPage = pageProvider.page;
      switch (newPage) {
        case 0:
          {
            return const HomePage();
          }
        case 1:
          {
            return const GalleryPage();
          }
        case 2:
          {
            return const SearchPage();
          }
        case 3:
          {
            return const PlaylistPage();
          }
        default:
          {
            return const HomePage();
          }
      }
    }

    Widget customBottomNavigation() {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 24),
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color(0xFF424242).withOpacity(0),
              const Color(0xFF424242),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const [
            NavigationItem(
              icon: Icons.home_outlined,
              label: 'Home',
              index: 0,
            ),
            NavigationItem(
              icon: Icons.perm_media_outlined,
              label: 'Gallery',
              index: 1,
            ),
            NavigationItem(
              icon: Icons.search,
              label: 'Search',
              index: 2,
            ),
            NavigationItem(
              icon: Icons.library_books_outlined,
              label: 'Playlist',
              index: 3,
            ),
          ],
        ),
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: backgroundUserColor,
      body: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          buildContent(),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const PlayingTile(),
              customBottomNavigation(),
            ],
          ),
        ],
      ),
    );
  }
}

class NavigationItem extends StatelessWidget {
  const NavigationItem({
    required this.icon,
    required this.label,
    required this.index,
    Key? key,
  }) : super(key: key);

  final String label;
  final IconData icon;
  final int index;

  @override
  Widget build(BuildContext context) {
    PageProvider pageProvider = Provider.of<PageProvider>(context);

    return GestureDetector(
      onTap: () {
        pageProvider.setPage = index;
        if (index == 0) {
          pageProvider.setHomePage = 0;
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 32,
            color:
                pageProvider.page == index ? secondaryColor : primaryUserColor,
          ),
          Text(
            label,
            style: pageProvider.page == index
                ? secondaryColorText.copyWith(
                    fontSize: 12,
                    fontWeight: semibold,
                  )
                : primaryUserColorText.copyWith(
                    fontSize: 12,
                    fontWeight: semibold,
                  ),
          ),
        ],
      ),
    );
  }
}
