import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:music_player/models/audio_model.dart';
import 'package:music_player/providers/user_provider.dart';
import 'package:music_player/shared/theme.dart';
import 'package:provider/provider.dart';

class RewindPopUp extends StatefulWidget {
  final String title;
  final List<AudioModel> audios;
  final Function() add;
  final TextEditingController controller;
  const RewindPopUp(
      {super.key,
      required this.title,
      required this.add,
      required this.controller,
      required this.audios});

  @override
  State<RewindPopUp> createState() => _RewindPopUpState();
}

bool isLoading = false;

class _RewindPopUpState extends State<RewindPopUp> {
  int selectedItemStart = 0;
  int selectedItemFinish = 0;
  List<DropdownMenuItem> generateItems(int lenList) {
    List<DropdownMenuItem> dropdownItems = [];
    for (int i = 0; i <= lenList; i++) {
      dropdownItems.add(DropdownMenuItem(
        value: i,
        alignment: Alignment.center,
        child: Text(
          i.toString(),
          style: primaryAdminColorText.copyWith(fontSize: 14),
        ),
      ));
    }
    return dropdownItems;
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    return AlertDialog(
        backgroundColor: userProvider.user.role == "USER"
            ? backgroundUserColor
            : const Color.fromARGB(255, 224, 224, 224),
        actions: [
          Visibility(
            visible: !isLoading,
            child: TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'CANCEL',
                style: userProvider.user.role == "USER"
                    ? primaryUserColorText
                    : primaryAdminColorText,
              ),
            ),
          ),
          Visibility(
            visible: !isLoading,
            child: TextButton(
              onPressed: () async {
                setState(() {
                  isLoading = true;
                });
                final navigator = Navigator.of(context);
                await widget.add();
                navigator.pop(true);
                setState(() {
                  isLoading = false;
                });
              },
              child: Text(
                'SAVE',
                style: userProvider.user.role == "USER"
                    ? primaryUserColorText
                    : primaryAdminColorText,
              ),
            ),
          )
        ],
        title: Visibility(
          visible: !isLoading,
          child: Text(
            widget.title,
            style: userProvider.user.role == "USER"
                ? primaryUserColorText
                : primaryAdminColorText,
          ),
        ),
        content: isLoading
            ? SizedBox(
                width: 30,
                height: 30,
                child: Center(
                  child: LoadingAnimationWidget.staggeredDotsWave(
                    color: userProvider.user.role == "USER"
                        ? primaryUserColor
                        : primaryAdminColor,
                    size: 32,
                  ),
                ),
              )
            : Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                height: 200,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(30)),
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
                              borderRadius:
                                  BorderRadius.circular(defaultRadius)),
                          child: DropdownButtonFormField(
                            icon: Icon(
                              Icons.keyboard_arrow_down_outlined,
                              color: backgroundUserColor,
                            ),
                            style: primaryAdminColorText.copyWith(fontSize: 14),
                            decoration: InputDecoration(
                              hintStyle:
                                  primaryAdminColorText.copyWith(fontSize: 16),
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: primaryAdminColor),
                              ),
                            ),
                            value: widget.audios.isEmpty
                                ? null
                                : (selectedItemStart == 0
                                    ? null
                                    : selectedItemStart),
                            items: generateItems(widget.audios.length),
                            onChanged: (value) {
                              setState(() {
                                selectedItemStart = value;
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
                              borderRadius:
                                  BorderRadius.circular(defaultRadius)),
                          child: DropdownButtonFormField(
                            icon: Icon(
                              Icons.keyboard_arrow_down_outlined,
                              color: backgroundUserColor,
                            ),
                            style: primaryAdminColorText.copyWith(fontSize: 14),
                            decoration: InputDecoration(
                              hintStyle:
                                  primaryAdminColorText.copyWith(fontSize: 16),
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: primaryAdminColor),
                              ),
                            ),
                            value: widget.audios.isEmpty
                                ? null
                                : (selectedItemFinish == 0
                                    ? null
                                    : selectedItemFinish),
                            items: generateItems(widget.audios.length),
                            onChanged: (value) {
                              setState(() {
                                selectedItemFinish = value;
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
