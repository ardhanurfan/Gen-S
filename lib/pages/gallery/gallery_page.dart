import 'package:flutter/material.dart';
import 'package:music_player/pages/gallery/empty_gallery_page.dart';
import 'package:music_player/providers/user_provider.dart';
import 'package:music_player/shared/theme.dart';
import 'package:music_player/widgets/custom_popup.dart';
import 'package:music_player/widgets/gallery_grid.dart';
import 'package:music_player/widgets/setting_button.dart';
import 'package:provider/provider.dart';

import '../../providers/gallery_provider.dart';

class GalleryPage extends StatelessWidget {
  const GalleryPage({super.key});

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    GalleryProvider galleryProvider = Provider.of<GalleryProvider>(context);
    UserProvider userProvider = Provider.of<UserProvider>(context);
    TextEditingController galleryController = TextEditingController(text: "");

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
                  "Gallery",
                  style: userProvider.user?.role == "USER" ||
                          userProvider.user == null
                      ? primaryUserColorText.copyWith(
                          fontSize: 24, fontWeight: bold)
                      : primaryAdminColorText.copyWith(
                          fontSize: 24, fontWeight: bold),
                ),
                userProvider.user?.role == "USER" || userProvider.user == null
                    ? const SettingButton()
                    : InkWell(
                        highlightColor: userProvider.user?.role == "USER" ||
                                userProvider.user == null
                            ? const Color.fromARGB(255, 73, 73, 73)
                            : const Color.fromARGB(255, 200, 200, 200),
                        borderRadius: BorderRadius.circular(360),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return CustomPopUp(
                                controller: galleryController,
                                title: "Gallery Name",
                                add: () async {
                                  if (await galleryProvider.addGallery(
                                      name: galleryController.text)) {
                                    ScaffoldMessenger.of(context)
                                        .removeCurrentSnackBar();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor: successColor,
                                        content: const Text(
                                          'Add gallery successfuly',
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context)
                                        .removeCurrentSnackBar();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor: alertColor,
                                        content: Text(
                                          galleryProvider.errorMessage,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    );
                                  }
                                },
                              );
                            },
                          );
                        },
                        child: Icon(
                          Icons.add,
                          color: primaryAdminColor,
                          size: 36,
                        ),
                      ),
              ],
            ),
          ),
          backgroundColor:
              userProvider.user?.role == "USER" || userProvider.user == null
                  ? backgroundUserColor
                  : backgroundAdminColor,
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
              deviceWidth <= kMobileBreakpoint ? 1 / 1.4 : 1 / 1.2,
          crossAxisSpacing: deviceWidth <= kMobileBreakpoint ? 30 : 10,
        ),
        children: galleryProvider.galleries
            .map(
              (gallery) => GalleryGrid(
                gallery: gallery,
              ),
            )
            .toList(),
      );
    }

    return Scaffold(
      backgroundColor:
          userProvider.user?.role == "USER" || userProvider.user == null
              ? backgroundUserColor
              : backgroundAdminColor,
      body: SafeArea(
        child: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              header(),
            ];
          },
          body: galleryProvider.galleries.isEmpty
              ? const EmptyGalleryPage()
              : content(),
        ),
      ),
    );
  }
}
