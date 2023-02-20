import 'package:flutter/material.dart';
import 'package:music_player/pages/pages_user/gallery_page.dart';
import 'package:music_player/pages/pages_user/playlist_page.dart';
import 'package:music_player/pages/pages_user/search_page.dart';
import 'package:music_player/providers/page_provider.dart';
import 'package:provider/provider.dart';

import '../../shared/theme.dart';
import 'home_page.dart';

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
        width: double.infinity,
        height: 120,
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
      backgroundColor: backgroundColor,
      body: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          buildContent(),
          customBottomNavigation(),
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
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 40,
            color: pageProvider.page == index ? secondaryColor : primaryColor,
          ),
          Text(
            label,
            style: pageProvider.page == index
                ? secondaryColorText.copyWith(
                    fontSize: 12,
                    fontWeight: semibold,
                  )
                : primaryColorText.copyWith(
                    fontSize: 12,
                    fontWeight: semibold,
                  ),
          ),
        ],
      ),
    );
  }
}
