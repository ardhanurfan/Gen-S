// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:music_player/pages/home/empty_state_page.dart';
import 'package:music_player/providers/user_provider.dart';
import 'package:music_player/shared/theme.dart';
import 'package:music_player/widgets/custom_popup_success.dart';
import 'package:music_player/widgets/popup_not_logged_in.dart';
import 'package:music_player/widgets/setting_button.dart';
import 'package:music_player/widgets/sort_by_tile.dart';
import 'package:provider/provider.dart';

import '../../../providers/page_provider.dart';
import '../../providers/audio_player_provider.dart';
import '../../providers/audio_provider.dart';
import '../../providers/sort_by_provider.dart';
import 'audios_home_content.dart';
import 'suggested_home_content.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    PageProvider pageProvider = Provider.of<PageProvider>(context);
    AudioProvider audioProvider = Provider.of<AudioProvider>(context);
    AudioPlayerProvider audioPlayerProvider =
        Provider.of<AudioPlayerProvider>(context);
    SortByProvider sortByProvider = Provider.of<SortByProvider>(context);
    UserProvider userProvider = Provider.of<UserProvider>(context);

    handleAddAudio() async {
      if (userProvider.user == null) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return const PopUpNotLoggedIn();
          },
        );
      } else {
        if (await audioProvider.audioPicker()) {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => CustomPopUpSuccess(
              title: 'Add Audio',
              add: () async {
                String audioTitle =
                    audioProvider.audioPickedPath.split('/').last;
                if (audioTitle.contains(".mp3")) {
                  audioTitle = audioTitle.split(".mp3").first;
                } else if (audioTitle.contains(".m4a")) {
                  audioTitle = audioTitle.split(".m4a").first;
                }
                if (await audioProvider.addAudio(
                    title: audioTitle,
                    audioPath: audioProvider.audioPickedPath,
                    imagesPath: [])) {
                  audioPlayerProvider.addAudio(audio: audioProvider.audios[0]);
                  ScaffoldMessenger.of(context).removeCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: successColor,
                      content: const Text(
                        'Add Audio Successfuly',
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
                        audioProvider.errorMessage,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }
              },
            ),
          );
        } else {
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: alertColor,
              content: Text(
                audioProvider.errorMessage,
                textAlign: TextAlign.center,
              ),
            ),
          );
        }
      }
    }

    Widget header() {
      return SliverPadding(
        padding: EdgeInsets.only(
            right: defaultMargin, left: defaultMargin, top: 24, bottom: 10),
        sliver: SliverAppBar(
          stretch: true,
          elevation: 0,
          automaticallyImplyLeading: false,
          titleSpacing: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                userProvider.user?.role == "ADMIN" && userProvider.user != null
                    ? "assets/logo-black-font.png"
                    : "assets/logo-white-font.png",
                fit: BoxFit.cover,
                width: 100,
              ),
              Row(
                children: [
                  InkWell(
                    highlightColor: userProvider.user?.role == "USER" ||
                            userProvider.user == null
                        ? const Color.fromARGB(255, 73, 73, 73)
                        : const Color.fromARGB(255, 200, 200, 200),
                    borderRadius: BorderRadius.circular(360),
                    onTap: () async {
                      handleAddAudio();
                    },
                    child: Icon(
                      Icons.add,
                      size: 36,
                      color: userProvider.user?.role == "USER" ||
                              userProvider.user == null
                          ? primaryUserColor
                          : primaryAdminColor,
                    ),
                  ),
                  const SizedBox(width: 16),
                  const SettingButton(),
                ],
              )
            ],
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

    Widget switchContent() {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Row(
              children: [
                HomePageNav(title: 'Suggested', index: 0, width: 66),
                SizedBox(width: 24),
                HomePageNav(title: 'Audios', index: 1, width: 38),
                SizedBox(width: 24),
              ],
            ),
            Visibility(
              visible: pageProvider.homePage != 0,
              child: PopupMenuButton(
                icon: RotatedBox(
                  quarterTurns: 1,
                  child: Icon(Icons.compare_arrows,
                      size: 28,
                      color: userProvider.user?.role == "USER" ||
                              userProvider.user == null
                          ? primaryUserColor
                          : primaryAdminColor),
                ),
                color: userProvider.user?.role == "USER" ||
                        userProvider.user == null
                    ? dropDownColor
                    : const Color.fromARGB(255, 223, 223, 223),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(defaultRadius),
                ),
                elevation: 4,
                onSelected: (value) {
                  switch (value) {
                    case 2:
                      audioProvider.sortAscending();
                      break;
                    case 1:
                      audioProvider.sortDescending();
                      break;
                    case 0:
                      audioProvider.sortByDate();
                      break;
                    default:
                      audioProvider.sortByDate();
                  }
                  sortByProvider.setSortBy = value;
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(
                      value: 2,
                      child: SortByTile(title: "Ascending", index: 2)),
                  const PopupMenuItem(
                      value: 1,
                      child: SortByTile(title: "Descending", index: 1)),
                  const PopupMenuItem(
                      value: 0,
                      child: SortByTile(title: "Date Added", index: 0)),
                ],
              ),
            ),
          ],
        ),
      );
    }

    Widget changeContent() {
      int indexHome = pageProvider.homePage;
      bool isNullHistory = audioProvider.historyMosts.isEmpty ||
          audioProvider.historyMosts.isEmpty;
      bool isNullAudio = audioProvider.audios.isEmpty;

      switch (indexHome) {
        case 0:
          return isNullHistory
              ? const EmptyStatePage()
              : const SuggestedHomeContent();
        case 1:
          return isNullAudio
              ? const EmptyStatePage()
              : const SongsHomeContent();
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
    UserProvider userProvider = Provider.of<UserProvider>(context);

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
                : userProvider.user?.role == "USER" || userProvider.user == null
                    ? primaryUserColorText.copyWith(
                        fontSize: 12,
                        fontWeight: medium,
                      )
                    : primaryAdminColorText.copyWith(
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
