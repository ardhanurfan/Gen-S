import 'package:flutter/material.dart';
import 'package:music_player/pages/forgot_password_page.dart';
import 'package:music_player/pages/import_audio_page.dart';
import 'package:music_player/pages/pages_user/recently_played_page.dart';

import 'pages/sign_up_page.dart';
import 'pages/sign_in_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SignUpPage(),
      routes: {
        '/sign-in': (context) => const SignInPage(),
        '/sign-up': (context) => const SignUpPage(),
        '/forgot-password': (context) => const ForgotPasswordPage(),
        '/import-audio': (context) => const ImportAudioPage(),
        '/recently-played': (context) => const RecentlyPlayedPage(),
      },
    );
  }
}
