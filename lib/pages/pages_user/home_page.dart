import 'package:flutter/material.dart';
import 'package:music_player/shared/theme.dart';

import 'suggested_home_content.dart';
import 'songs_home_content.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return SliverPadding(
        padding:
            EdgeInsets.only(right: defaultMargin, left: defaultMargin, top: 24),
        sliver: SliverAppBar(
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
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Suggested',
                        style: secondaryColorText.copyWith(
                          fontSize: 12,
                          fontWeight: medium,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 14),
                        height: 3,
                        width: 70,
                        decoration: BoxDecoration(
                          color: secondaryColor,
                          borderRadius: BorderRadius.circular(18),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(width: 24),
                GestureDetector(
                  onTap: () {},
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Songs',
                        style: primaryColorText.copyWith(
                          fontSize: 12,
                          fontWeight: medium,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 14),
                        height: 3,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(18),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(width: 24),
                GestureDetector(
                  onTap: () {},
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Albums',
                        style: primaryColorText.copyWith(
                          fontSize: 12,
                          fontWeight: medium,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 14),
                        height: 3,
                        width: 50,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(18),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            GestureDetector(
              onTap: () {},
              child: RotatedBox(
                quarterTurns: 1,
                child: Icon(
                  Icons.compare_arrows,
                  size: 28,
                  color: primaryColor,
                ),
              ),
            )
          ],
        ),
      );
    }

    Widget content() {
      return Column(
        children: [
          switchContent(),
          const SongsHomeContent(),
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
