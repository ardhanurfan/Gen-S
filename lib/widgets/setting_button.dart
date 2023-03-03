import 'package:flutter/material.dart';
import 'package:music_player/providers/user_provider.dart';
import 'package:music_player/shared/theme.dart';
import 'package:provider/provider.dart';

class SettingButton extends StatefulWidget {
  const SettingButton({
    Key? key,
  }) : super(key: key);

  @override
  State<SettingButton> createState() => _SettingButtonState();
}

bool isLoading = false;

class _SettingButtonState extends State<SettingButton> {
  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);

    handleLogout() async {
      setState(() {
        isLoading = true;
      });

      if (await userProvider.logout(token: userProvider.user.token)) {
        Navigator.pushNamedAndRemoveUntil(
            context, '/sign-in', (route) => false);
      } else {
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: alertColor,
            content: Text(
              userProvider.errorMessage,
              textAlign: TextAlign.center,
            ),
          ),
        );
      }

      setState(() {
        isLoading = false;
      });
    }

    return PopupMenuButton(
      color: primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(defaultRadius),
      ),
      elevation: 4,
      onSelected: (value) {
        if (value == 0) {
          handleLogout();
        }
      },
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 0,
          child: Text(
            'Logout',
            style: TextStyle(color: alertColor),
          ),
        ),
      ],
      child: isLoading
          ? Container(
              padding: const EdgeInsets.all(4),
              height: 32,
              width: 32,
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            )
          : Icon(
              Icons.settings_outlined,
              color: primaryColor,
              size: 32,
            ),
    );
  }
}
