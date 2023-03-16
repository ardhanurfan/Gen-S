import 'package:flutter/material.dart';
import 'package:music_player/pages/settings_page.dart';

class SettingButton extends StatelessWidget {
  const SettingButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: const Icon(Icons.settings_outlined),
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const SettingsPage()));
      },
    );
  }
}
