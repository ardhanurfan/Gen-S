import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:music_player/providers/playlist_provider.dart';
import 'package:music_player/shared/theme.dart';
import 'package:music_player/widgets/audio_tile.dart';
import 'package:provider/provider.dart';

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
        padding: const EdgeInsets.only(top: 27, bottom: 37),
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
              height: 24,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  name,
                  style:
                      primaryColorText.copyWith(fontSize: 20, fontWeight: bold),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(
                  width: 15,
                ),
                Icon(
                  Icons.more_horiz,
                  color: primaryColor,
                  size: 20,
                )
              ],
            ),
            Text(
              playlistProvider.audios.length.toString(),
              style: primaryColorText.copyWith(fontSize: 12, fontWeight: light),
            )
          ],
        ),
      );
    }

    Widget header() {
      return SliverPadding(
        padding:
            EdgeInsets.only(right: defaultMargin, left: defaultMargin, top: 24),
        sliver: SliverAppBar(
          stretch: true,
          elevation: 0,
          automaticallyImplyLeading: false,
          titleSpacing: 0,
          title: Column(
            children: [
              playlistInfo(),
              Row(
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
                  Icon(
                    Icons.add,
                    color: primaryColor,
                  )
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

    Widget audioList() {
      return ReorderableListView(
        onReorder: (oldIndex, newIndex) {},
        children: playlistProvider.audios
            .map(
              (audio) => AudioTile(
                key: Key(audio.id.toString()),
                audio: audio,
                playlist: playlistProvider.audios,
              ),
            )
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
          body: audioList(),
        ),
      ),
    );
  }
}
