import 'dart:io';

import 'package:flutter/material.dart';
import 'package:music_player/providers/ads_provider.dart';
import 'package:music_player/providers/images_provider.dart';
import 'package:music_player/widgets/custom_button.dart';
import 'package:provider/provider.dart';

import '../shared/theme.dart';

class AdsDetailPage extends StatefulWidget {
  const AdsDetailPage({
    super.key,
    this.title = '',
    this.frequency = '',
    this.link = '',
    this.location = '',
    this.adsId = 0,
  });

  final String title;
  final String frequency;
  final String link;
  final String location;
  final int adsId;

  @override
  State<AdsDetailPage> createState() => _AdsDetailPageState();
}

String contentPath = '';
File? contentFile;
String location = '';
bool isBottom = true;
TextEditingController titleController = TextEditingController(text: '');
TextEditingController frequencyController = TextEditingController(text: '');
TextEditingController linkController = TextEditingController(text: '');

class _AdsDetailPageState extends State<AdsDetailPage> {
  @override
  void initState() {
    super.initState();
    contentPath = '';
    contentFile = null;
    titleController = TextEditingController(text: widget.title);
    frequencyController = TextEditingController(text: widget.frequency);
    linkController = TextEditingController(text: widget.link);
    location = widget.location;
  }

  @override
  Widget build(BuildContext context) {
    AdsProvider adsProvider = Provider.of<AdsProvider>(context);
    ImagesProvider imagesProvider = Provider.of<ImagesProvider>(context);

    bool isEdit = widget.frequency.isNotEmpty &&
        widget.title.isNotEmpty &&
        widget.link.isNotEmpty;

    Future<void> handlePicker() async {
      imagesProvider.setCroppedImageFile = null;
      await imagesProvider.pickImage();
      await imagesProvider.cropImage(imageFile: imagesProvider.imageFile);
      setState(() {
        if (imagesProvider.croppedImagePath.isNotEmpty) {
          contentPath = imagesProvider.croppedImagePath;
          contentFile = imagesProvider.croppedImageFile;
        }
      });
    }

    Future<void> handleSave() async {
      if (contentPath.isNotEmpty) {
        if (await adsProvider.addAds(
          contentPath: contentPath,
          frequency: frequencyController.text,
          link: linkController.text,
          title: titleController.text,
          location: location,
        )) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: successColor,
              content: const Text(
                'Add Ads Successfuly',
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
                adsProvider.errorMessage,
                textAlign: TextAlign.center,
              ),
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: alertColor,
            content: const Text(
              "Content is empty",
              textAlign: TextAlign.center,
            ),
          ),
        );
      }
    }

    Future<void> handleEditSave() async {
      if (await adsProvider.editAds(
        adsId: widget.adsId,
        frequency: frequencyController.text,
        link: linkController.text,
        title: titleController.text,
        location: location,
      )) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: successColor,
            content: const Text(
              'Edit Ads Successfuly',
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
              adsProvider.errorMessage,
              textAlign: TextAlign.center,
            ),
          ),
        );
      }
    }

    Widget header() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: primaryAdminColor,
            ),
          ),
          Text(
            "Edit Ads",
            style:
                primaryAdminColorText.copyWith(fontSize: 24, fontWeight: bold),
          )
        ],
      );
    }

    Widget content() {
      return ListView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        padding: EdgeInsets.symmetric(
            horizontal: defaultMargin, vertical: defaultMargin),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              header(),
              Visibility(
                visible: !isEdit,
                child: Padding(
                  padding: const EdgeInsets.only(top: 60),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: Center(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          contentFile != null
                              ? Image.file(
                                  contentFile!,
                                  height: isBottom ? 60 : 240,
                                  width: isBottom ? double.infinity : 240,
                                  fit: BoxFit.cover,
                                )
                              : Container(
                                  color:
                                      const Color.fromARGB(255, 223, 223, 223),
                                ),
                          Container(
                            height: isBottom ? 60 : 240,
                            width: isBottom ? double.infinity : 240,
                            color: Colors.black45,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    await handlePicker();
                                  },
                                  child: Icon(
                                    Icons.upload,
                                    size: 24,
                                    color: primaryUserColor,
                                  ),
                                ),
                                Visibility(
                                  visible: contentPath.isNotEmpty,
                                  child: Text(
                                    'Content Picked',
                                    style: primaryUserColorText.copyWith(
                                      fontSize: 12,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                "Title",
                style: primaryAdminColorText.copyWith(
                    fontSize: 14, fontWeight: medium),
              ),
              const SizedBox(
                height: 3,
              ),
              TextField(
                controller: titleController,
                style: primaryAdminColorText.copyWith(fontSize: 14),
                cursorColor: primaryAdminColor,
                decoration: InputDecoration(
                  hintStyle: primaryAdminColorText.copyWith(fontSize: 16),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: primaryAdminColor),
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Text(
                "Link",
                style: primaryAdminColorText.copyWith(
                    fontSize: 14, fontWeight: medium),
              ),
              const SizedBox(
                height: 3,
              ),
              TextField(
                controller: linkController,
                style: primaryAdminColorText.copyWith(fontSize: 14),
                cursorColor: primaryAdminColor,
                decoration: InputDecoration(
                  hintStyle: primaryAdminColorText.copyWith(fontSize: 16),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: primaryAdminColor),
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Text(
                "Frequency",
                style: primaryAdminColorText,
              ),
              TextField(
                keyboardType: TextInputType.number,
                controller: frequencyController,
                style: primaryAdminColorText.copyWith(fontSize: 14),
                cursorColor: primaryAdminColor,
                decoration: InputDecoration(
                  hintStyle: primaryAdminColorText.copyWith(fontSize: 16),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: primaryAdminColor),
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Text(
                "Location",
                style: primaryAdminColorText,
              ),
              DropdownButtonFormField(
                style: primaryAdminColorText.copyWith(fontSize: 14),
                decoration: InputDecoration(
                  hintStyle: primaryAdminColorText.copyWith(fontSize: 16),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: primaryAdminColor),
                  ),
                ),
                value: location.isEmpty ? null : location,
                items: const [
                  DropdownMenuItem(
                    value: 'bottom',
                    child: Text('Bottom'),
                  ),
                  DropdownMenuItem(
                    value: 'player',
                    child: Text('Player'),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    location = value ?? '';
                    isBottom = value == 'bottom';
                  });
                },
              ),
              const SizedBox(
                height: 24,
              ),
              CustomButton(
                radiusButton: 32,
                buttonColor: secondaryColor,
                buttonText: "Save",
                onPressed: () async {
                  if (isEdit) {
                    await handleEditSave();
                  } else {
                    await handleSave();
                  }
                },
                heightButton: 53,
              )
            ],
          ),
        ],
      );
    }

    return Scaffold(
      body: SafeArea(child: content()),
    );
  }
}
