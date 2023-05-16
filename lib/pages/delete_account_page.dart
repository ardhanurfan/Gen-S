import 'package:flutter/material.dart';
import 'package:music_player/providers/audio_player_provider.dart';
import 'package:music_player/shared/theme.dart';
import 'package:music_player/widgets/custom_button.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';
import '../widgets/loading_button.dart';

class DeleteAccountPage extends StatefulWidget {
  const DeleteAccountPage({super.key});

  @override
  State<DeleteAccountPage> createState() => _DeleteAccountPageState();
}

bool isLoading = false;

class _DeleteAccountPageState extends State<DeleteAccountPage> {
  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    AudioPlayerProvider audioPlayerProvider =
        Provider.of<AudioPlayerProvider>(context);
    handleDelete() async {
      setState(() {
        isLoading = true;
      });
      if (await userProvider.delete(token: userProvider.user.token)) {
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
                color: primaryUserColor,
              ),
            ),
            Text(
              "Delete Account",
              style: primaryUserColorText.copyWith(
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "We have received your request to delete your account on our application. We understand that you no longer wish to continue using our services, and we respect your decision.",
              textAlign: TextAlign.justify,
              style: primaryUserColorText.copyWith(fontSize: 14),
            ),
            Text(
              "\nPlease be aware that by deleting your account, you will permanently lose access to all the features and content associated with it. This includes any audio files and playlists you have uploaded and saved within the application. Once the account deletion process is complete, it cannot be reversed.",
              textAlign: TextAlign.justify,
              style: primaryUserColorText.copyWith(fontSize: 14),
            ),
            Text(
              "\nThank you for being a part of our community, and we appreciate your feedback throughout your time using our application. If you ever decide to come back, we would be more than happy to welcome you again.",
              textAlign: TextAlign.justify,
              style: primaryUserColorText.copyWith(fontSize: 14),
            ),
            const SizedBox(
              height: 60,
            ),
            isLoading
                ? LoadingButton(
                    radiusButton: 32,
                    buttonColor: alertColor,
                    heightButton: 53,
                  )
                : CustomButton(
                    radiusButton: 32,
                    buttonColor: alertColor,
                    buttonText: "Delete My Account",
                    onPressed: () {
                      handleDelete();
                    },
                    heightButton: 53),
            const SizedBox(
              height: 24,
            ),
            CustomButton(
                radiusButton: 32,
                buttonColor: secondaryColor,
                buttonText: "Cancel",
                onPressed: () {
                  Navigator.pop(context);
                },
                heightButton: 53)
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: backgroundUserColor,
      body: SafeArea(
          child: ListView(
        children: [header(), content()],
      )),
    );
  }
}
