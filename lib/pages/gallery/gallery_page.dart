import 'package:flutter/material.dart';
import 'package:music_player/shared/theme.dart';
import 'package:music_player/widgets/setting_button.dart';

import 'detail_gallery_page.dart';

class GalleryPage extends StatelessWidget {
  const GalleryPage({super.key});

  @override
  Widget build(BuildContext context) {
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Albums",
                style:
                    primaryColorText.copyWith(fontSize: 24, fontWeight: bold),
              ),
              Row(
                children: [
                  Icon(
                    Icons.add,
                    size: 36,
                    color: primaryColor,
                  ),
                  const SizedBox(width: 16),
                  const SettingButton(),
                ],
              ),
            ],
          ),
          backgroundColor: backgroundColor,
          floating: true,
          snap: true,
        ),
      );
    }

    Widget albumGrid() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const DetailGalleryPage()));
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.asset(
                "assets/ex_gallery.png",
                // width: 160,
                // height: 160,
              ),
            ),
          ),
          Text(
            "Album Name",
            style: primaryColorText.copyWith(fontSize: 16, fontWeight: medium),
          ),
          Text(
            "4736",
            style: primaryColorText.copyWith(fontSize: 12),
          ),
        ],
      );
    }

    Widget content() {
      return GridView(
        padding:
            const EdgeInsets.only(top: 24, bottom: 100, left: 20, right: 20),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 1 / 1.4, crossAxisSpacing: 30),
        children: [
          albumGrid(),
          albumGrid(),
          albumGrid(),
          albumGrid(),
          albumGrid(),
          albumGrid(),
          albumGrid(),
          albumGrid()
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
        ));
  }
}
