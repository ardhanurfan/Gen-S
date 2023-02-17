import 'package:flutter/material.dart';
import 'package:music_player/pages/pages_user/empty_state_page.dart';
import 'package:music_player/pages/pages_user/home_page.dart';

import 'pages/pages_user/artist_page.dart';
import 'pages/forgot_password_page.dart';
import 'pages/import_audio_page.dart';
import 'pages/pages_user/most_played_page.dart';
import 'pages/pages_user/recently_played_page.dart';
import 'pages/sign_up_page.dart';
import 'pages/sign_in_page.dart';

void main() {
  runApp(const MyApp());
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      scrollBehavior: MyBehavior(),
      home: const HomePage(),
      routes: {
        '/sign-in': (context) => const SignInPage(),
        '/sign-up': (context) => const SignUpPage(),
        '/forgot-password': (context) => const ForgotPasswordPage(),
        '/import-audio': (context) => const ImportAudioPage(),
        '/recently-played': (context) => const RecentlyPlayedPage(),
        '/most-played': (context) => const MostPlayedPage(),
        '/artist': (context) => const ArtistPage(),
      },
    );
  }
}
