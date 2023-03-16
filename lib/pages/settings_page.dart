import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
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

    handleLogout() async {
      setState(() {
        isLoading = true;
      });

      if (await userProvider.logout(token: userProvider.user.token)) {
        Navigator.pushNamedAndRemoveUntil(
            context, '/sign-in', (route) => false);
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
                color: primaryColor,
              ),
            ),
            Text(
              "Settings",
              style: primaryColorText.copyWith(
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
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 30),
                  child: ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: userProvider.user.photoUrl,
                      height: 84,
                      width: 84,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userProvider.user.username,
                      style: primaryColorText.copyWith(
                          fontSize: 20, fontWeight: bold),
                    ),
                    Text(
                      userProvider.user.email,
                      style: primaryColorText.copyWith(fontSize: 12),
                    ),
                  ],
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 84 - defaultMargin, vertical: 60),
              child: isLoading
                  ? LoadingButton(
                      radiusButton: 32,
                      buttonColor: secondaryColor,
                      heightButton: 53,
                    )
                  : CustomButton(
                      radiusButton: 32,
                      buttonColor: secondaryColor,
                      buttonText: "Log Out",
                      onPressed: () {
                        handleLogout();
                      },
                      heightButton: 53),
            )
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor,
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
