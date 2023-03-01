import 'package:flutter/material.dart';
import 'package:music_player/pages/pages_user/albums_home_content.dart';
import 'package:music_player/shared/theme.dart';
import 'package:provider/provider.dart';

import '../../providers/page_provider.dart';
import 'suggested_home_content.dart';
import 'songs_home_content.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    PageProvider pageProvider = Provider.of<PageProvider>(context);

    Widget header() {
      return SliverPadding(
        padding:
            EdgeInsets.only(right: defaultMargin, left: defaultMargin, top: 24),
        sliver: SliverAppBar(
          stretch: true,
          elevation: 0,
          automaticallyImplyLeading: false,
          titleSpacing: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(
                Icons.add,
                size: 36,
                color: primaryColor,
              ),
              const SizedBox(width: 16),
              Icon(
                Icons.settings_outlined,
                size: 32,
                color: primaryColor,
              )
            ],
          ),
          backgroundColor: backgroundColor,
          floating: true,
          snap: true,
        ),
      );
    }

    Widget switchContent() {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: const [
                HomePageNav(title: 'Suggested', index: 0, width: 66),
                SizedBox(width: 24),
                HomePageNav(title: 'Audios', index: 1, width: 38),
                SizedBox(width: 24),
              ],
            ),
            Visibility(
              visible: pageProvider.homePage != 0,
              child: GestureDetector(
                onTap: () {},
                child: RotatedBox(
                  quarterTurns: 1,
                  child: Icon(
                    Icons.compare_arrows,
                    size: 28,
                    color: primaryColor,
                  ),
                ),
              ),
            )
          ],
        ),
      );
    }

    Widget changeContent() {
      int indexHome = pageProvider.homePage;
      switch (indexHome) {
        case 0:
          return const SuggestedHomeContent();
        case 1:
          return const SongsHomeContent();

        default:
          return const SuggestedHomeContent();
      }
    }

    Widget content() {
      return Column(
        children: [
          switchContent(),
          changeContent(),
        ],
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              header(),
            ];
          },
          body: content(),
        ),
      ),
    );
  }
}

// Ini untuk ganti content suggested, songs, albums
class HomePageNav extends StatelessWidget {
  const HomePageNav({
    Key? key,
    required this.title,
    required this.index,
    required this.width,
  }) : super(key: key);

  final String title;
  final int index;
  final double width;

  @override
  Widget build(BuildContext context) {
    PageProvider pageProvider = Provider.of<PageProvider>(context);

    return GestureDetector(
      onTap: () {
        pageProvider.setHomePage = index;
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            title,
            style: pageProvider.homePage == index
                ? secondaryColorText.copyWith(
                    fontSize: 12,
                    fontWeight: medium,
                  )
                : primaryColorText.copyWith(
                    fontSize: 12,
                    fontWeight: medium,
                  ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 14),
            height: 3,
            width: width,
            decoration: BoxDecoration(
              color: pageProvider.homePage == index
                  ? secondaryColor
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(18),
            ),
          )
        ],
      ),
    );
  }
}
