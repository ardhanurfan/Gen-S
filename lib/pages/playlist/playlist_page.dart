import 'package:flutter/material.dart';
import 'package:music_player/pages/playlist/empty_playlist_page.dart';
import 'package:music_player/providers/playlist_provider.dart';
import 'package:music_player/shared/theme.dart';
import 'package:music_player/widgets/custom_popup.dart';
import 'package:music_player/widgets/playlist_tile.dart';
import 'package:music_player/widgets/setting_button.dart';
import 'package:provider/provider.dart';

class PlaylistPage extends StatelessWidget {
  const PlaylistPage({super.key});

  @override
  Widget build(BuildContext context) {
    PlaylistProvider playlistProvider = Provider.of<PlaylistProvider>(context);
    TextEditingController controller = TextEditingController();

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
              Row(
                children: [
                  Text(
                    "Playlist",
                    style: primaryColorText.copyWith(
                        fontSize: 24, fontWeight: bold),
                  ),
                  const SizedBox(
                    width: 21,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: RotatedBox(
                      quarterTurns: 1,
                      child: Icon(
                        Icons.compare_arrows,
                        size: 28,
                        color: primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => CustomPopUp(
                          controller: controller,
                          title: "Playlist Name",
                          add: () async {
                            if (await playlistProvider.addPlaylist(
                                name: controller.text)) {
                              ScaffoldMessenger.of(context)
                                  .removeCurrentSnackBar();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: successColor,
                                  content: const Text(
                                    'Add Playlist Successfuly',
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
                    child: Icon(
                      Icons.add,
                      size: 36,
                      color: primaryColor,
                    ),
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

    Widget content() {
      return ListView(
        padding: EdgeInsets.only(
            right: defaultMargin, left: defaultMargin, top: 24, bottom: 160),
        children: playlistProvider.playlists
            .map((playlist) => PlaylistTile(playlist: playlist))
            .toList(),
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
          body: playlistProvider.playlists.isEmpty
              ? const EmptyPlaylistPage()
              : content(),
        ),
      ),
    );
  }
}
