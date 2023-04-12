import 'package:flutter/material.dart';
import 'package:music_player/models/audio_model.dart';
import 'package:music_player/providers/audio_player_provider.dart';
import 'package:music_player/providers/playlist_provider.dart';
import 'package:music_player/shared/theme.dart';
import 'package:provider/provider.dart';

class RewindPopUp extends StatefulWidget {
  const RewindPopUp({
    super.key,
  });

  @override
  State<RewindPopUp> createState() => _RewindPopUpState();
}

int _selectedStart = 1;
int _selectedFinish = 1;

class _RewindPopUpState extends State<RewindPopUp> {
  @override
  void initState() {
    _selectedStart = 1;
    _selectedFinish = 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    PlaylistProvider playlistProvider = Provider.of<PlaylistProvider>(context);
    AudioPlayerProvider audioPlayerProvider =
        Provider.of<AudioPlayerProvider>(context);

    return AlertDialog(
        backgroundColor: backgroundUserColor,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'CANCEL',
              style: primaryUserColorText,
            ),
          ),
          TextButton(
            onPressed: () {
              List<AudioModel> playRangeAudios = [];
              for (var i = _selectedStart - 1; i < _selectedFinish; i++) {
                playRangeAudios.add(playlistProvider.audios[i]);
              }
              audioPlayerProvider.setPlay(playRangeAudios, 0);
              Navigator.of(context).pop(true);
            },
            child: Text(
              'PLAY',
              style: primaryUserColorText,
            ),
          )
        ],
        title:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            'Play Range',
            style: primaryUserColorText,
          ),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(
              Icons.close,
              color: primaryUserColor,
            ),
          )
        ]),
        content: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          height: 200,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Start",
                    style: primaryUserColorText.copyWith(fontSize: 16),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    width: 70,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(defaultRadius)),
                    child: DropdownButtonFormField(
                      style: primaryAdminColorText.copyWith(fontSize: 14),
                      decoration: InputDecoration(
                        hintStyle: primaryAdminColorText.copyWith(fontSize: 16),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: primaryAdminColor),
                        ),
                      ),
                      value: playlistProvider.audios.isEmpty
                          ? null
                          : _selectedStart,
                      items: playlistProvider.audios.map((audio) {
                        int number = playlistProvider.audios.indexOf(audio) + 1;
                        return DropdownMenuItem(
                          value: number,
                          child: Text(number.toString()),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedStart = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 36,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Finish",
                    style: primaryUserColorText.copyWith(fontSize: 16),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    width: 70,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(defaultRadius)),
                    child: DropdownButtonFormField(
                      style: primaryAdminColorText.copyWith(fontSize: 14),
                      decoration: InputDecoration(
                        hintStyle: primaryAdminColorText.copyWith(fontSize: 16),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: primaryAdminColor),
                        ),
                      ),
                      value: playlistProvider.audios.isEmpty
                          ? null
                          : _selectedFinish,
                      items: playlistProvider.audios.map((audio) {
                        int number = playlistProvider.audios.indexOf(audio) + 1;
                        return DropdownMenuItem(
                          value: number,
                          child: Text(number.toString()),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedFinish = value!;
                        });
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
