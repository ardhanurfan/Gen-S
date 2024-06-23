// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:music_player/pages/delete_account_page.dart';
import 'package:music_player/providers/audio_player_provider.dart';
import 'package:music_player/providers/user_provider.dart';
import 'package:music_player/widgets/custom_button.dart';
import 'package:music_player/widgets/loading_button.dart';
import 'package:provider/provider.dart';

import '../shared/theme.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

bool isLoading = false;

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    AudioPlayerProvider audioPlayerProvider =
        Provider.of<AudioPlayerProvider>(context, listen: false);

    handleLogout() async {
      setState(() {
        isLoading = true;
      });
      if (userProvider.user == null) {
        Navigator.pushNamedAndRemoveUntil(
            context, '/sign-in', (route) => false);
      } else {
        if (await userProvider.logout(token: userProvider.user!.token)) {
          Navigator.pushNamedAndRemoveUntil(
              context, '/sign-in', (route) => false);
          if (audioPlayerProvider.currentPlaylist.isNotEmpty) {
            await audioPlayerProvider.playlist.clear();
          }
        } else {
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: alertColor,
              content: Text(
                userProvider.errorMessage,
                textAlign: TextAlign.center,
              ),
            ),
          );
        }
      }

      setState(() {
        isLoading = false;
      });
    }

    Widget header() {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin, vertical: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back,
                color: userProvider.user?.role == "USER" ||
                        userProvider.user == null
                    ? primaryUserColor
                    : primaryAdminColor,
              ),
            ),
            Text(
              "Settings",
              style:
                  userProvider.user?.role == "USER" || userProvider.user == null
                      ? primaryUserColorText.copyWith(
                          fontWeight: bold, fontSize: 24, letterSpacing: 1.3)
                      : primaryAdminColorText.copyWith(
                          fontWeight: bold, fontSize: 24, letterSpacing: 1.3),
            ),
          ],
        ),
      );
    }

    Widget content() {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin, vertical: 30),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // FOTO PROFIL
                // Padding(
                //   padding: const EdgeInsets.only(right: 30),
                //   child: ClipOval(
                //     child: CachedNetworkImage(
                //       imageUrl:
                //           "https://ui-avatars.com/api/?name=${userProvider.user.username}+&color=7F9CF5&background=EBF4FF",
                //       height: 84,
                //       width: 84,
                //       fit: BoxFit.fill,
                //     ),
                //   ),
                // ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      userProvider.user != null
                          ? userProvider.user!.username
                          : "GUEST",
                      style: userProvider.user?.role == "USER" ||
                              userProvider.user == null
                          ? primaryUserColorText.copyWith(
                              fontSize: 20, fontWeight: bold)
                          : primaryAdminColorText.copyWith(
                              fontSize: 20, fontWeight: bold),
                    ),
                    Text(
                      userProvider.user != null ? userProvider.user!.email : "",
                      style: userProvider.user?.role == "USER" ||
                              userProvider.user == null
                          ? primaryUserColorText.copyWith(fontSize: 12)
                          : primaryAdminColorText.copyWith(
                              fontSize: 12, fontWeight: bold),
                    ),
                  ],
                )
              ],
            ),
            Visibility(
              visible: userProvider.user?.role == "USER" ||
                  userProvider.user == null,
              child: Padding(
                padding: EdgeInsets.only(
                    left: 84 - defaultMargin,
                    top: 60,
                    right: 84 - defaultMargin),
                child: isLoading
                    ? Visibility(
                        visible: userProvider.user != null,
                        child: LoadingButton(
                          radiusButton: 32,
                          buttonColor: alertColor,
                          heightButton: 53,
                        ),
                      )
                    : Visibility(
                        visible: userProvider.user != null,
                        child: CustomButton(
                            radiusButton: 32,
                            buttonColor: alertColor,
                            buttonText: "Delete Account",
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const DeleteAccountPage()));
                            },
                            heightButton: 53),
                      ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 84 - defaultMargin, vertical: 20),
              child: isLoading
                  ? LoadingButton(
                      radiusButton: 32,
                      buttonColor: secondaryColor,
                      heightButton: 53,
                    )
                  : CustomButton(
                      radiusButton: 32,
                      buttonColor: secondaryColor,
                      buttonText:
                          userProvider.user == null ? "Log In" : "Log Out",
                      onPressed: () {
                        handleLogout();
                      },
                      heightButton: 53),
            ),
            const SizedBox(
              height: 40,
            ),
            Text(
              "Version 1.2.0",
              style:
                  userProvider.user?.role == "USER" || userProvider.user == null
                      ? primaryUserColorText.copyWith(fontSize: 12)
                      : primaryAdminColorText.copyWith(
                          fontSize: 12, fontWeight: bold),
            )
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor:
          userProvider.user?.role == "USER" || userProvider.user == null
              ? backgroundUserColor
              : backgroundAdminColor,
      body: SafeArea(
        child: Column(
          children: [
            header(),
            content(),
          ],
        ),
      ),
    );
  }
}
