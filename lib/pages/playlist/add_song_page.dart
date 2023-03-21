import 'package:flutter/material.dart';
import 'package:music_player/widgets/add_audio_playlist_tile.dart';
import 'package:provider/provider.dart';

import '../../models/audio_model.dart';
import '../../providers/audio_provider.dart';
import '../../providers/playlist_provider.dart';
import '../../shared/theme.dart';

class AddSongPage extends StatefulWidget {
  const AddSongPage({required this.playlistId, super.key});

  final int playlistId;

  @override
  State<AddSongPage> createState() => _AddSongPageState();
}

class _AddSongPageState extends State<AddSongPage> {
  List<AudioModel> foundAudio = [];
  List<AudioModel> allData = [];

  @override
  void initState() {
    AudioProvider audioProvider =
        Provider.of<AudioProvider>(context, listen: false);
    allData = audioProvider.audios;
    foundAudio = audioProvider.audios;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    PlaylistProvider playlistProvider = Provider.of<PlaylistProvider>(context);

    void updateFound(String value) {
      setState(() {
        foundAudio = allData
            .where((audio) =>
                audio.title.toLowerCase().contains(value.toLowerCase()))
            .toList();
      });
    }

    Widget content() {
      return ListView(
        padding: EdgeInsets.symmetric(
            horizontal: defaultMargin, vertical: defaultMargin),
        children: [
          Row(
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
            ],
          ),
          const SizedBox(
            height: 30,
          ),
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
            visible: foundAudio.isNotEmpty,
            child: Column(
              children: foundAudio.map(
                (audio) {
                  bool contain = playlistProvider.audios.contains(audio);
                  return AddAudioPlaylistTile(
                    playlistId: widget.playlistId,
                    audio: audio,
                    isAdded: contain,
                  );
                },
              ).toList(),
            ),
          ),
          const SizedBox(height: 160),
        ],
      );
    }

    return Scaffold(
      backgroundColor: backgroundUserColor,
      body: SafeArea(child: content()),
    );
  }
}
