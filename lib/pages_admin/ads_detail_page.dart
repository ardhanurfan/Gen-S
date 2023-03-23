import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:music_player/widgets/custom_button.dart';

import '../shared/theme.dart';

class AdsDetailPage extends StatefulWidget {
  const AdsDetailPage({super.key});

  @override
  State<AdsDetailPage> createState() => _AdsDetailPageState();
}

class _AdsDetailPageState extends State<AdsDetailPage> {
  DateTime dateTime = DateTime.now();
  TextEditingController titleController = TextEditingController(text: "");
  TextEditingController frequencyController = TextEditingController(text: "");
  @override
  Widget build(BuildContext context) {
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
        padding: EdgeInsets.symmetric(
            horizontal: defaultMargin, vertical: defaultMargin),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              header(),
              Padding(
                padding: const EdgeInsets.only(
                    top: 60, left: 50, right: 50, bottom: 30),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Image.asset(
                    "assets/ex_gallery.png",
                    height: 220,
                    fit: BoxFit.fill,
                  ),
                ),
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
                        borderSide: BorderSide(color: primaryAdminColor))),
              ),
              const SizedBox(
                height: 24,
              ),
              Text(
                "Time",
                style: primaryAdminColorText,
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: pickDateTime,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today_rounded,
                          color: primaryAdminColor,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Column(
                          children: [
                            Text(
                                DateFormat('yyyy/MM/dd - hh:mm')
                                    .format(dateTime),
                                style: primaryAdminColorText.copyWith()),
                          ],
                        )
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 8),
                      width: double.infinity,
                      height: 0.85,
                      color: primaryAdminColor,
                    )
                  ],
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
                controller: titleController,
                style: primaryAdminColorText.copyWith(fontSize: 14),
                cursorColor: primaryAdminColor,
                decoration: InputDecoration(
                    hintStyle: primaryAdminColorText.copyWith(fontSize: 16),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: primaryAdminColor))),
              ),
              const SizedBox(
                height: 24,
              ),
              CustomButton(
                  radiusButton: 32,
                  buttonColor: secondaryColor,
                  buttonText: "Save",
                  onPressed: () {},
                  heightButton: 53)
            ],
          ),
        ],
      );
    }

    return Scaffold(
      body: SafeArea(child: content()),
    );
  }

  Future pickDateTime() async {
    DateTime? date = await pickDate();
    if (date == null) return;

    TimeOfDay? time = await pickTime();
    if (time == null) return;

    final pickedDateTime =
        DateTime(date.year, date.month, date.day, time.hour, time.minute);

    setState(() {
      dateTime = pickedDateTime;
    });
  }

  Future<DateTime?> pickDate() => showDatePicker(
      context: context,
      initialDate: dateTime,
      firstDate: DateTime.now(),
      lastDate: DateTime(2500));

  Future<TimeOfDay?> pickTime() => showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: dateTime.hour, minute: dateTime.minute));
}
