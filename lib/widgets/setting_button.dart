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
    return InkWell(
      highlightColor:
          userProvider.user?.role == "USER" || userProvider.user == null
              ? const Color.fromARGB(255, 73, 73, 73)
              : const Color.fromARGB(255, 200, 200, 200),
      borderRadius: BorderRadius.circular(360),
      child: Icon(
        Icons.settings_outlined,
        color: userProvider.user?.role == "USER" || userProvider.user == null
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
