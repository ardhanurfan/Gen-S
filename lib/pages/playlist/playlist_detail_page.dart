import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:music_player/providers/playlist_provider.dart';
import 'package:music_player/providers/user_provider.dart';
import 'package:music_player/shared/theme.dart';
import 'package:music_player/widgets/audio_tile_playlist.dart';
import 'package:music_player/widgets/default_image.dart';
import 'package:music_player/widgets/rewind_popup.dart';
import 'package:provider/provider.dart';

import '../../widgets/playing_tile.dart';
import 'add_song_page.dart';

class PlaylistDetailPage extends StatelessWidget {
  const PlaylistDetailPage(
      {super.key, required this.playlistId, required this.name});

  final int playlistId;
  final String name;

  @override
  Widget build(BuildContext context) {
    PlaylistProvider playlistProvider = Provider.of<PlaylistProvider>(context);
    UserProvider userProvider = Provider.of<UserProvider>(context);

    Widget playlistInfo() {
      return Padding(
        padding: EdgeInsets.only(
            top: 16, bottom: 8, right: defaultMargin, left: defaultMargin),
        child: Column(
          children: [
            playlistProvider.audios.isEmpty
                ? const DefaultImage(type: ImageType.playlist, size: 200)
                : playlistProvider.audios[0].images.isEmpty
                    ? const DefaultImage(type: ImageType.playlist, size: 200)
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: CachedNetworkImage(
                          imageUrl: playlistProvider.audios[0].images[0].url,
                          fit: BoxFit.cover,
                          width: 200,
                          height: 200,
                          alignment: Alignment.center,
                        ),
                      ),
            const SizedBox(
              height: 16,
            ),
            Text(
              name,
              style:
                  primaryUserColorText.copyWith(fontSize: 20, fontWeight: bold),
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              '${playlistProvider.audios.length} audio',
              style: primaryUserColorText.copyWith(
                  fontSize: 12, fontWeight: light),
            )
          ],
        ),
      );
    }

    Widget header() {
      return Padding(
        padding:
            EdgeInsets.only(right: defaultMargin, left: defaultMargin, top: 24),
        child: Column(
          children: [
            Row(
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
                Row(
                  children: [
                    InkWell(
                      highlightColor: userProvider.user?.role == "USER" ||
                              userProvider.user == null
                          ? const Color.fromARGB(255, 73, 73, 73)
                          : const Color.fromARGB(255, 200, 200, 200),
                      borderRadius: BorderRadius.circular(360),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                AddSongPage(playlistId: playlistId),
                          ),
                        );
                      },
                      child: Icon(
                        Icons.add,
                        color: primaryUserColor,
                        size: 28,
                      ),
                    ),
                    const SizedBox(
                      width: 18,
                    ),
                    InkWell(
                      highlightColor: userProvider.user?.role == "USER" ||
                              userProvider.user == null
                          ? const Color.fromARGB(255, 73, 73, 73)
                          : const Color.fromARGB(255, 200, 200, 200),
                      borderRadius: BorderRadius.circular(360),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => const RewindPopUp(),
                        );
                      },
                      child: Icon(
                        Icons.sync,
                        color: primaryUserColor,
                        size: 28,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ],
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

    Widget audioList() {
      return Expanded(
        child: ReorderableListView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          proxyDecorator: proxyDecorator,
          padding: EdgeInsets.only(
              right: defaultMargin, left: defaultMargin, bottom: 100),
          onReorder: (oldIndex, newIndex) async {
            if (await playlistProvider.swapAudio(
                playlistId: playlistId,
                oldIndex: oldIndex,
                newIndex: newIndex)) {
              ScaffoldMessenger.of(context).removeCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: successColor,
                  content: const Text(
                    'Swap audio successfuly',
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
          children: playlistProvider.audios
              .map(
                (audio) => AudioTilePlaylist(
                  key: Key(audio.id.toString()),
                  audio: audio,
                  playlist: playlistProvider.audios,
                  playlistId: playlistId,
                ),
              )
              .toList(),
        ),
      );
    }

    return Scaffold(
      backgroundColor: backgroundUserColor,
      body: SafeArea(
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            Column(
              children: [
                header(),
                playlistInfo(),
                audioList(),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              child: const PlayingTile(),
            ),
          ],
        ),
      ),
    );
  }
}
