import 'package:flutter/material.dart';
import 'package:music_player/models/audio_model.dart';
import 'package:music_player/models/gallery_model.dart';
import 'package:music_player/models/playlist_model.dart';
import 'package:music_player/providers/audio_provider.dart';
import 'package:music_player/providers/playlist_provider.dart';
import 'package:music_player/shared/theme.dart';
import 'package:music_player/widgets/audio_tile.dart';
import 'package:music_player/widgets/playlist_tile.dart';
import 'package:provider/provider.dart';

import '../providers/gallery_provider.dart';
import '../widgets/gallery_grid.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<AudioModel> foundAudio = [];
  List<GalleryModel> foundGallery = [];
  List<PlaylistModel> foundPlaylist = [];

  @override
  Widget build(BuildContext context) {
    AudioProvider audioProvider = Provider.of<AudioProvider>(context);
    GalleryProvider galleryProvider = Provider.of<GalleryProvider>(context);
    PlaylistProvider playlistProvider = Provider.of<PlaylistProvider>(context);

    void updateFound(String value) {
      setState(() {
        if (value.isNotEmpty) {
          foundAudio = audioProvider.audios
              .where((audio) =>
                  audio.title.toLowerCase().contains(value.toLowerCase()))
              .toList();
          foundGallery = galleryProvider.galleries
              .where((gallery) =>
                  gallery.name.toLowerCase().contains(value.toLowerCase()))
              .toList();
          foundPlaylist = playlistProvider.playlists
              .where((playlist) =>
                  playlist.name.toLowerCase().contains(value.toLowerCase()))
              .toList();
        } else {
          foundAudio = [];
          foundGallery = [];
          foundPlaylist = [];
        }
      });
    }

    Widget content() {
      return ListView(
        padding: EdgeInsets.symmetric(
            horizontal: defaultMargin, vertical: defaultMargin),
        children: [
          // SEARCH BAR
          TextFormField(
            onChanged: (value) => updateFound(value),
            style: darkGreyText.copyWith(fontSize: 14),
            cursorColor: darkGreyColor,
            decoration: InputDecoration(
              hintText: "start searching",
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              fillColor: primaryUserColor,
              filled: true,
              hintStyle: darkGreyText.copyWith(
                fontSize: 16,
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32),
                  borderSide: BorderSide(color: primaryUserColor, width: 5)),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(32),
                borderSide: BorderSide(
                  color: primaryUserColor,
                  width: 3,
                  style: BorderStyle.solid,
                ),
              ),
            ),
          ),
          //
          // Hasil Search
          //
          // EMPTY STATE
          Visibility(
            visible: foundAudio.isEmpty && foundGallery.isEmpty,
            child: Container(
              margin: const EdgeInsets.only(top: 90),
              child: Image.asset(
                "assets/search_empty.png",
                height: 283,
                width: 270,
              ),
            ),
          ),
          // ADA ISI
          Visibility(
            visible: foundAudio.isNotEmpty || foundGallery.isNotEmpty,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Visibility(
                  visible: foundAudio.isNotEmpty,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 32),
                    child: Text(
                      "Audio",
                      style: primaryUserColorText.copyWith(
                          fontSize: 20, fontWeight: bold),
                    ),
                  ),
                ),
                Column(
                  children: foundAudio
                      .map(
                        (audio) => AudioTile(
                          audio: audio,
                          playlist: audioProvider.audios,
                        ),
                      )
                      .toList(),
                ),
                Visibility(
                  visible: foundPlaylist.isNotEmpty,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 32),
                    child: Text(
                      "Playlist",
                      style: primaryUserColorText.copyWith(
                          fontSize: 20, fontWeight: bold),
                    ),
                  ),
                ),
                Column(
                  children: foundPlaylist
                      .map(
                        (playlist) => PlaylistTile(
                          playlist: playlist,
                        ),
                      )
                      .toList(),
                ),
                Visibility(
                  visible: foundGallery.isNotEmpty,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 32),
                    child: Text(
                      "Gallery",
                      style: primaryUserColorText.copyWith(
                          fontSize: 20, fontWeight: bold),
                    ),
                  ),
                ),
                Column(
                  children: [
                    GridView(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1 / 1.5,
                        crossAxisSpacing: 30,
                      ),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: foundGallery
                          .map(
                            (gallery) => GalleryGrid(
                              gallery: gallery,
                            ),
                          )
                          .toList(),
                    )
                  ],
                )
              ],
            ),
          ),
          const SizedBox(height: 160),
        ],
      );
    }

    return Scaffold(
      backgroundColor: backgroundUserColor,
      body: SafeArea(
        child: content(),
      ),
    );
  }
}
