import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:music_player/models/ads_model.dart';
import 'package:music_player/pages_admin/ads_detail_page.dart';
import 'package:music_player/providers/ads_provider.dart';
import 'package:music_player/providers/user_provider.dart';
import 'package:provider/provider.dart';

import '../shared/theme.dart';
import '../widgets/delete_popup.dart';

class AdsPage extends StatelessWidget {
  const AdsPage({super.key});

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    AdsProvider adsProvider = Provider.of<AdsProvider>(context);
    UserProvider userProvider = Provider.of<UserProvider>(context);

    Widget header() {
      return SliverPadding(
        padding: const EdgeInsets.only(top: 24),
        sliver: SliverAppBar(
          stretch: true,
          elevation: 0,
          automaticallyImplyLeading: false,
          titleSpacing: 0,
          title: Padding(
            padding: EdgeInsets.symmetric(horizontal: defaultMargin),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Ads Content",
                  style: primaryAdminColorText.copyWith(
                      fontSize: 24, fontWeight: bold),
                ),
                InkWell(
                  highlightColor: userProvider.user?.role == "USER" ||
                          userProvider.user == null
                      ? const Color.fromARGB(255, 73, 73, 73)
                      : const Color.fromARGB(255, 200, 200, 200),
                  borderRadius: BorderRadius.circular(360),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AdsDetailPage(),
                    ),
                  ),
                  child: Icon(
                    Icons.add,
                    color: primaryAdminColor,
                    size: 36,
                  ),
                ),
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
        padding: EdgeInsets.only(
            top: 24,
            bottom: 240,
            left: deviceWidth <= kMobileBreakpoint ? 20 : 80,
            right: deviceWidth <= kMobileBreakpoint ? 20 : 80),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: deviceWidth <= kMobileBreakpoint ? 2 : 3,
          childAspectRatio:
              deviceWidth <= kMobileBreakpoint ? 1 / 1.4 : 1 / 1.3,
          crossAxisSpacing: 30,
        ),
        children: adsProvider.defAds.map((ads) => AdsGrid(ads: ads)).toList(),
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

class AdsGrid extends StatelessWidget {
  const AdsGrid({
    required this.ads,
    Key? key,
  }) : super(key: key);

  final AdsModel ads;

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    AdsProvider adsProvider = Provider.of<AdsProvider>(context);

    Future<void> handleDelete() async {
      if (await adsProvider.deleteAds(adsId: ads.id)) {
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: successColor,
            content: const Text(
              'Delete ads successfuly',
              textAlign: TextAlign.center,
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: alertColor,
            content: Text(
              adsProvider.errorMessage,
              textAlign: TextAlign.center,
            ),
          ),
        );
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AdsDetailPage(
                  title: ads.title,
                  link: ads.link,
                  frequency: ads.frequency.toString(),
                  adsId: ads.id,
                  location: ads.location,
                ),
              ),
            );
          },
          child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: CachedNetworkImage(
                imageUrl: ads.url,
                height: deviceWidth <= kMobileBreakpoint ? 160 : 340,
                width: deviceWidth <= kMobileBreakpoint ? 160 : 340,
                fit: BoxFit.cover,
              )),
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
                      ads.title,
                      overflow: TextOverflow.ellipsis,
                      style: primaryAdminColorText.copyWith(
                          fontSize: 16, fontWeight: medium),
                    ),
                    Text(
                      "${ads.frequency} frequency",
                      overflow: TextOverflow.ellipsis,
                      style: primaryAdminColorText.copyWith(fontSize: 12),
                    ),
                    Text(
                      ads.location,
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
                      builder: (context) => DeletePopUp(
                        delete: () async {
                          await handleDelete();
                        },
                      ),
                    );
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
    );
  }
}
