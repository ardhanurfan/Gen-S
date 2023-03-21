import 'package:flutter/material.dart';

import '../shared/theme.dart';

class AdsPage extends StatelessWidget {
  const AdsPage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return SliverPadding(
        padding: EdgeInsets.only(
            right: defaultMargin, left: defaultMargin, top: 24, bottom: 42),
        sliver: SliverAppBar(
          stretch: true,
          elevation: 0,
          automaticallyImplyLeading: false,
          titleSpacing: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "Ads Settings",
                style: primaryAdminColorText.copyWith(
                    fontSize: 24, fontWeight: bold),
              )
            ],
          ),
          backgroundColor: backgroundAdminColor,
          floating: true,
          snap: true,
        ),
      );
    }

    Widget content() {
      return Column(
        children: [
          Container(
            padding:
                EdgeInsets.symmetric(vertical: 17, horizontal: defaultMargin),
            decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(color: secondaryColor, width: 1),
                    bottom: BorderSide(color: secondaryColor, width: 1))),
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Ads Content",
                  style: primaryAdminColorText.copyWith(fontSize: 16),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 20,
                  color: primaryAdminColor,
                )
              ],
            ),
          ),
          Container(
            padding:
                EdgeInsets.symmetric(vertical: 17, horizontal: defaultMargin),
            decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(color: secondaryColor, width: 0),
                    bottom: BorderSide(color: secondaryColor, width: 1))),
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Time & Ads Location",
                  style: primaryAdminColorText.copyWith(fontSize: 16),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 20,
                  color: primaryAdminColor,
                )
              ],
            ),
          ),
          Container(
            padding:
                EdgeInsets.symmetric(vertical: 17, horizontal: defaultMargin),
            decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(color: secondaryColor, width: 0),
                    bottom: BorderSide(color: secondaryColor, width: 1))),
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Ads Shows Frequency",
                  style: primaryAdminColorText.copyWith(fontSize: 16),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 20,
                  color: primaryAdminColor,
                )
              ],
            ),
          )
        ],
      );
    }

    return Scaffold(
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
