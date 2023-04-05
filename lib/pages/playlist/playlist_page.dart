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
    TextEditingController controller = TextEditingController(text: '');

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
                    style: primaryUserColorText.copyWith(
                        fontSize: 24, fontWeight: bold),
                  ),
                  const SizedBox(
                    width: 21,
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
                                    'Add playlist successfuly',
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
                      color: primaryUserColor,
                    ),
                  ),
                  const SizedBox(width: 16),
                  const SettingButton(),
                ],
              ),
            ],
          ),
          backgroundColor: backgroundUserColor,
          floating: true,
          snap: true,
        ),
      );
    }

    Widget proxyDecorator(
        Widget child, int index, Animation<double> animation) {
      return AnimatedBuilder(
        animation: animation,
        builder: (BuildContext context, Widget? child) {
          return Material(
            elevation: 1,
            color: Colors.transparent,
            shadowColor: darkGreyColor,
            child: child,
          );
        },
        child: child,
      );
    }

    Widget content() {
      return ReorderableListView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        proxyDecorator: proxyDecorator,
        padding: EdgeInsets.only(
            right: defaultMargin, left: defaultMargin, top: 24, bottom: 240),
        onReorder: (int oldIndex, int newIndex) async {
          if (await playlistProvider.swapPlaylist(
              oldIndex: oldIndex, newIndex: newIndex)) {
            ScaffoldMessenger.of(context).removeCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: successColor,
                content: const Text(
                  'Swap playlist successfuly',
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
        children: playlistProvider.playlists
            .map(
              (playlist) => PlaylistTile(
                playlist: playlist,
                key: Key(playlist.id.toString()),
              ),
            )
            .toList(),
      );
    }

    return Scaffold(
      backgroundColor: backgroundUserColor,
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
