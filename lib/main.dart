import 'package:flutter/material.dart';
import 'package:music_player/pages/audio_player_page.dart';
import 'package:music_player/providers/audio_player_provider.dart';
import 'package:music_player/providers/audio_provider.dart';
import 'package:music_player/providers/gallery_provider.dart';
import 'package:music_player/providers/page_provider.dart';
import 'package:music_player/providers/playlist_provider.dart';
import 'package:music_player/providers/sort_by_provider.dart';
import 'package:music_player/providers/user_provider.dart';
import 'package:provider/provider.dart';

import 'pages/auth/forgot_password_page.dart';
import 'pages/auth/sign_in_page.dart';
import 'pages/auth/sign_up_page.dart';
import 'pages/import_audio_page.dart';
import 'pages/main_page.dart';
import 'pages/splash_page.dart';

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PageProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => AudioProvider()),
        ChangeNotifierProvider(create: (context) => GalleryProvider()),
        ChangeNotifierProvider(create: (context) => PlaylistProvider()),
        ChangeNotifierProvider(create: (context) => AudioPlayerProvider()),
        ChangeNotifierProvider(create: (context) => SortByProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
        ),
        scrollBehavior: MyBehavior(),
        routes: {
          '/': (context) => const SplashPage(),
          '/main': (context) => const MainPage(),
          '/sign-in': (context) => const SignInPage(),
          '/sign-up': (context) => const SignUpPage(),
          '/forgot-password': (context) => const ForgotPasswordPage(),
          '/import-audio': (context) => const ImportAudioPage(),
          '/player': (context) => const AudioPlayerPage(),
        },
      ),
    );
  }
}
