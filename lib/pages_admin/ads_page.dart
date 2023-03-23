import 'package:flutter/material.dart';
import 'package:music_player/pages_admin/ads_detail_page.dart';

import '../shared/theme.dart';
import '../widgets/delete_popup.dart';

class AdsPage extends StatelessWidget {
  const AdsPage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return SliverPadding(
        padding: const EdgeInsets.only(top: 24, bottom: 42),
        sliver: SliverAppBar(
          stretch: true,
          elevation: 0,
          automaticallyImplyLeading: false,
          titleSpacing: 0,
          title: Padding(
            padding: EdgeInsets.symmetric(horizontal: defaultMargin),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Ads Content",
                  style: primaryAdminColorText.copyWith(
                      fontSize: 24, fontWeight: bold),
                )
              ],
            ),
          ),
          backgroundColor: backgroundAdminColor,
          floating: true,
          snap: true,
        ),
      );
    }

    Widget content() {
      return GridView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        padding:
            const EdgeInsets.only(top: 24, bottom: 100, left: 20, right: 20),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1 / 1.4,
          crossAxisSpacing: 30,
        ),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AdsDetailPage()));
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Image.asset(
                    "assets/ex_gallery.png",
                    height: 160,
                    width: 160,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Keripik Tempe",
                            overflow: TextOverflow.ellipsis,
                            style: primaryAdminColorText.copyWith(
                                fontSize: 16, fontWeight: medium),
                          ),
                          Text(
                            "11.00 - 17.00",
                            overflow: TextOverflow.ellipsis,
                            style: primaryAdminColorText.copyWith(fontSize: 12),
                          ),
                          Text(
                            "Below, Pop Up",
                            overflow: TextOverflow.ellipsis,
                            style: primaryAdminColorText.copyWith(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    PopupMenuButton(
                      icon: Icon(
                        Icons.more_vert,
                        color: primaryAdminColor,
                      ),
                      color: const Color.fromARGB(255, 223, 223, 223),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(defaultRadius),
                      ),
                      elevation: 4,
                      onSelected: (value) {
                        if (value == 0) {
                          showDialog(
                              context: context,
                              builder: (context) => DeletePopUp(delete: () {}));
                        }
                      },
                      itemBuilder: (BuildContext context) => [
                        PopupMenuItem(
                            value: 0,
                            child: Text(
                              "Delete",
                              style: primaryAdminColorText,
                            ))
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      );
    }

    return Scaffold(
      backgroundColor: backgroundAdminColor,
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
