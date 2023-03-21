import 'package:flutter/material.dart';
import 'package:music_player/pages/settings_page.dart';
import 'package:music_player/providers/user_provider.dart';
import 'package:music_player/shared/theme.dart';
import 'package:provider/provider.dart';

class SettingButton extends StatelessWidget {
  const SettingButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    return GestureDetector(
      child: Icon(
        Icons.settings_outlined,
        color: userProvider.user.role == "USER"
            ? primaryUserColor
            : primaryAdminColor,
      ),
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const SettingsPage()));
      },
    );
  }
}
