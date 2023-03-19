import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:music_player/models/playlist_model.dart';
import 'package:music_player/pages/playlist/playlist_detail_page.dart';
import 'package:music_player/providers/playlist_provider.dart';
import 'package:music_player/shared/theme.dart';
import 'package:provider/provider.dart';

class PlaylistTile extends StatelessWidget {
  const PlaylistTile({
    required this.playlist,
    Key? key,
  }) : super(key: key);

  final PlaylistModel playlist;

  @override
  Widget build(BuildContext context) {
    PlaylistProvider playlistProvider = Provider.of<PlaylistProvider>(context);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      color: backgroundColor,
      child: GestureDetector(
        onTap: () {
          playlistProvider.setAudios = playlist.audios;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PlaylistDetailPage(
                playlistId: playlist.id,
                name: playlist.name,
              ),
            ),
          );
        },
        child: Row(
          children: [
            Container(
              height: 60,
              margin: const EdgeInsets.only(right: 24),
              width: 60,
              child: playlist.audios.isEmpty
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: Image.asset(
                        "assets/ex_playlist.png",
                      ),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: CachedNetworkImage(
                        imageUrl: playlist.audios[0].images[0].url,
                        fit: BoxFit.cover,
                      ),
                    ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    playlist.name,
                    overflow: TextOverflow.ellipsis,
                    style: primaryColorText.copyWith(
                        fontSize: 16, fontWeight: bold),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    playlist.audios.length.toString(),
                    overflow: TextOverflow.ellipsis,
                    style: primaryColorText.copyWith(
                        fontSize: 16, fontWeight: regular),
                  ),
                ],
              ),
            ),
            PopupMenuButton(
              icon: Icon(
                Icons.more_vert,
                color: primaryColor,
              ),
              color: dropDownColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(defaultRadius),
              ),
              elevation: 4,
              onSelected: (value) {
                if (value == 0) {
                } else {}
              },
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 0,
                  child: Center(
                    child: Text(
                      'Edit',
                      style: primaryColorText.copyWith(fontSize: 14),
                    ),
                  ),
                ),
                PopupMenuItem(
                  onTap: () {},
                  value: 1,
                  child: Center(
                    child: Text(
                      'Delete',
                      style: primaryColorText.copyWith(fontSize: 14),
                    ),
                  ),
                ),
                PopupMenuItem(
                  onTap: () {},
                  value: 2,
                  child: Center(
                    child: Text(
                      'Add song',
                      style: primaryColorText.copyWith(fontSize: 14),
                    ),
                  ),
                ),
                PopupMenuItem(
                  onTap: () {},
                  value: 3,
                  child: Center(
                    child: Text(
                      'Add to queue',
                      style: primaryColorText.copyWith(fontSize: 14),
                    ),
                  ),
                ),
                PopupMenuItem(
                  onTap: () {},
                  value: 4,
                  child: Center(
                    child: Text(
                      'Share',
                      style: primaryColorText.copyWith(fontSize: 14),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
