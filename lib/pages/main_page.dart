import 'package:flutter/material.dart';
import 'package:music_player/pages/gallery/gallery_page.dart';
import 'package:music_player/pages/playlist/playlist_page.dart';
import 'package:music_player/pages/search_page.dart';
import 'package:music_player/pages_admin/ads_page.dart';
import 'package:music_player/providers/ads_provider.dart';
import 'package:music_player/providers/page_provider.dart';
import 'package:music_player/providers/user_provider.dart';
import 'package:music_player/widgets/ads_banner.dart';
import 'package:music_player/widgets/playing_tile.dart';
import 'package:provider/provider.dart';

import '../../shared/theme.dart';
import 'home/home_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    PageProvider pageProvider = Provider.of<PageProvider>(context);
    UserProvider userProvider = Provider.of<UserProvider>(context);
    AdsProvider adsProvider = Provider.of<AdsProvider>(context);
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
            return userProvider.user?.role == "USER" ||
                    userProvider.user == null
                ? const PlaylistPage()
                : const AdsPage();
          }
        default:
          {
            return const HomePage();
          }
      }
    }

    Widget customBottomNavigationUser() {
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
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
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
            )
          ],
        ),
      );
    }

    Widget customBottomNavigationAdmin() {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 23),
        margin: const EdgeInsets.only(left: 20, right: 20, bottom: 34),
        width: double.infinity,
        decoration: BoxDecoration(
          color: backgroundAdminColor,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
          borderRadius: BorderRadius.circular(32),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
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
              icon: Icons.ads_click,
              label: 'Ads',
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
              userProvider.user?.role == "USER" || userProvider.user == null
                  ? customBottomNavigationUser()
                  : Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: customBottomNavigationAdmin(),
                    ),
              Visibility(
                  visible: (userProvider.user?.role == "USER" ||
                          userProvider.user == null) &&
                      adsProvider.adsBottom.isNotEmpty,
                  child: AdsBanner(
                    listOfAds: adsProvider.adsBottom,
                  ))
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
    UserProvider userProvider = Provider.of<UserProvider>(context);

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
            color: pageProvider.page == index
                ? secondaryColor
                : (userProvider.user?.role == "USER" ||
                        userProvider.user == null
                    ? primaryUserColor
                    : primaryAdminColor),
          ),
          Text(
            label,
            style: pageProvider.page == index
                ? secondaryColorText.copyWith(
                    fontSize: 12,
                    fontWeight: semibold,
                  )
                : (userProvider.user?.role == "USER" ||
                        userProvider.user == null
                    ? primaryUserColorText.copyWith(
                        fontSize: 12,
                        fontWeight: semibold,
                      )
                    : primaryAdminColorText.copyWith(
                        fontSize: 12,
                        fontWeight: semibold,
                      )),
          ),
        ],
      ),
    );
  }
}
