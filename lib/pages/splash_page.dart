import 'dart:async';

import 'package:flutter/material.dart';

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
    Timer(const Duration(seconds: 3), () async {
      final navigator = Navigator.of(context);
      navigator.pushNamedAndRemoveUntil('/sign-in', (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: backgroundColor, body: const SizedBox());
  }
}
