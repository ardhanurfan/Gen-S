import 'package:flutter/material.dart';
import 'package:music_player/providers/user_provider.dart';
import 'package:music_player/services/user_service.dart';
import 'package:provider/provider.dart';

import '../shared/theme.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    getInit();
    super.initState();
  }

  getInit() async {
    final navigator = Navigator.of(context);
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    final String? token = await UserService().getTokenPreference();
    if (token == null) {
      navigator.pushNamedAndRemoveUntil('/sign-in', (route) => false);
    } else {
      if (await userProvider.getUser(token: token)) {
        navigator.pushNamedAndRemoveUntil('/main', (route) => false);
      } else {
        navigator.pushNamedAndRemoveUntil('/sign-in', (route) => false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: backgroundColor, body: const SizedBox());
  }
}
