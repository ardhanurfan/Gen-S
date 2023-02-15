import 'package:flutter/material.dart';
import 'package:music_player/shared/theme.dart';

import 'suggested_home_content.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin, vertical: 24),
        child: Row(
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
      );
    }

    Widget switchContent() {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        height: 32,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Suggested',
                        style: secondaryColorText.copyWith(
                          fontSize: 12,
                          fontWeight: medium,
                        ),
                      ),
                      Container(
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Songs',
                        style: primaryColorText.copyWith(
                          fontSize: 12,
                          fontWeight: medium,
                        ),
                      ),
                      Container(
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Albums',
                        style: primaryColorText.copyWith(
                          fontSize: 12,
                          fontWeight: medium,
                        ),
                      ),
                      Container(
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
      return SuggestedHomeContent();
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            header(),
            switchContent(),
            content(),
          ],
        ),
      ),
    );
  }
}
