import 'package:flutter/material.dart';
import 'package:music_player/pages/pages_user/create_playlist_page.dart';
import 'package:music_player/pages/pages_user/playlist_detail_page.dart';
import 'package:music_player/shared/theme.dart';

class PlaylistPage extends StatelessWidget {
  const PlaylistPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const CreatePlaylistPage()));
                    },
                    child: Icon(
                      Icons.add,
                      size: 36,
                      color: primaryColor,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Icon(
                    Icons.settings_outlined,
                    size: 32,
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

    Widget playlistTile() {
      return Container(
        margin: const EdgeInsets.only(bottom: 24),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const PlaylistDetailPage()));
          },
          child: Row(
            children: [
              Container(
                height: 60,
                margin: const EdgeInsets.only(right: 24),
                width: 60,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/ex_playlist.png"),
                        fit: BoxFit.fill)),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Road Trip",
                      overflow: TextOverflow.ellipsis,
                      style: primaryColorText.copyWith(
                          fontSize: 16, fontWeight: bold),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      "85 songs",
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

    Widget content() {
      return ListView(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin, vertical: 47),
        children: [
          playlistTile(),
          playlistTile(),
          playlistTile(),
          playlistTile(),
          playlistTile(),
          playlistTile(),
          playlistTile(),
          playlistTile(),
          playlistTile(),
          playlistTile(),
          playlistTile(),
          playlistTile(),
          playlistTile(),
          playlistTile(),
          playlistTile(),
          playlistTile(),
          playlistTile(),
        ],
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
          body: content(),
        ),
      ),
    );
  }
}
