// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:music_player/providers/user_provider.dart';
import 'package:music_player/widgets/custom_popup.dart';
import 'package:provider/provider.dart';

import '../../../shared/theme.dart';
import '../../../widgets/custom_button.dart';
import '../../providers/playlist_provider.dart';

class EmptyPlaylistPage extends StatelessWidget {
  const EmptyPlaylistPage({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    PlaylistProvider playlistProvider = Provider.of<PlaylistProvider>(context);
    TextEditingController controller = TextEditingController(text: '');

    Widget mainIcon() {
      return Container(
        margin: const EdgeInsets.only(top: 120),
        height: 260,
        width: 340,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/playlist_empty.png"),
            fit: BoxFit.contain,
          ),
        ),
      );
    }

    Widget mainText() {
      return Center(
        child: Container(
          margin: const EdgeInsets.only(top: 49, bottom: 24),
          child: userProvider.user == null
              ? Column(
                  children: [
                    Text(
                      "You're not logged in  :(",
                      style: primaryUserColorText.copyWith(
                          fontSize: 24, fontWeight: bold),
                    ),
                    Text(
                      "Please login first to use this feature",
                      style: primaryUserColorText.copyWith(
                          fontSize: 16, fontWeight: bold),
                    )
                  ],
                )
              : Text(
                  "Your playlist is empty  :(",
                  style: primaryUserColorText.copyWith(
                      fontSize: 24, fontWeight: bold),
                ),
        ),
      );
    }

    Widget addAudioButton() {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: CustomButton(
          radiusButton: 32,
          buttonColor: orangeColor,
          buttonText: "Create Playlist",
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => CustomPopUp(
                controller: controller,
                title: "Playlist Name",
                add: () async {
                  if (await playlistProvider.addPlaylist(
                      name: controller.text)) {
                    ScaffoldMessenger.of(context).removeCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: successColor,
                        content: const Text(
                          'Add playlist successfuly',
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
                          playlistProvider.errorMessage,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  }
                },
              ),
            );
          },
          heightButton: 53,
        ),
      );
    }

    Widget content() {
      return ListView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        children: [
          mainIcon(),
          mainText(),
          Visibility(
              visible: userProvider.user != null, child: addAudioButton()),
        ],
      );
    }

    return content();
  }
}
