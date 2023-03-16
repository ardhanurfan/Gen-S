import 'package:flutter/material.dart';
import 'package:music_player/models/audio_model.dart';
import 'package:music_player/models/gallery_model.dart';
import 'package:music_player/providers/audio_provider.dart';
import 'package:music_player/shared/theme.dart';
import 'package:music_player/widgets/audio_tile.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<AudioModel> foundAudio = [];
  List<GalleryModel> foundGallery = [];

  @override
  Widget build(BuildContext context) {
    AudioProvider audioProvider = Provider.of<AudioProvider>(context);

    void updateFound(String value) {
      setState(() {
        if (value.isNotEmpty) {
          foundAudio = audioProvider.audios
              .where((audio) =>
                  audio.title.toLowerCase().contains(value.toLowerCase()))
              .toList();
        } else {
          foundAudio = [];
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
              fillColor: primaryColor,
              filled: true,
              hintStyle: darkGreyText.copyWith(
                fontSize: 16,
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32),
                  borderSide: BorderSide(color: primaryColor, width: 5)),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(32),
                borderSide: BorderSide(
                  color: primaryColor,
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
            visible: foundAudio.isEmpty,
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
                      style: primaryColorText.copyWith(
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
                  visible: foundGallery.isNotEmpty,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 32),
                    child: Text(
                      "Gallery",
                      style: primaryColorText.copyWith(
                          fontSize: 20, fontWeight: bold),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: content(),
      ),
    );
  }
}
