import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:music_player/providers/playlist_provider.dart';
import 'package:music_player/shared/theme.dart';
import 'package:music_player/widgets/audio_tile.dart';
import 'package:provider/provider.dart';

import 'add_song_page.dart';

class PlaylistDetailPage extends StatelessWidget {
  const PlaylistDetailPage(
      {super.key, required this.playlistId, required this.name});

  final int playlistId;
  final String name;

  @override
  Widget build(BuildContext context) {
    PlaylistProvider playlistProvider = Provider.of<PlaylistProvider>(context);

    Widget playlistInfo() {
      return Padding(
        padding: const EdgeInsets.only(top: 16, bottom: 8),
        child: Column(
          children: [
            playlistProvider.audios.isEmpty
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: Image.asset(
                      "assets/ex_playlist.png",
                      width: 200,
                      height: 200,
                      alignment: Alignment.center,
                    ),
                  )
                : playlistProvider.audios[0].images.isEmpty
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: Image.asset(
                          "assets/ex_playlist.png",
                          width: 200,
                          height: 200,
                          alignment: Alignment.center,
                        ),
                      )
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
                GestureDetector(
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
                  ),
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
                (audio) => AudioTile(
                  key: Key(audio.id.toString()),
                  audio: audio,
                  isPlaylist: true,
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
        child: Column(
          children: [
            header(),
            playlistInfo(),
            audioList(),
          ],
        ),
      ),
    );
  }
}
