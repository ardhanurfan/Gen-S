import 'package:flutter/material.dart';
import 'package:music_player/shared/theme.dart';
import 'package:video_player/video_player.dart';

class AdsBanner extends StatefulWidget {
  const AdsBanner({super.key});

  @override
  State<AdsBanner> createState() => _AdsBannerState();
}

class _AdsBannerState extends State<AdsBanner> {
  Stream<String> getUrl() async* {
    await Future.delayed(Duration(seconds: 3));
    yield 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4';
  }

  late VideoPlayerController _controller;

  @override
  void initState() {
    _controller = VideoPlayerController.network(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4')
      ..initialize().then((_) {
        // _controller.initialize().then((value) => _controller.play());
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // mutes the video
      _controller.setVolume(0);
      // Plays the video once the widget is build and loaded.
      _controller.play();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Uri url = Uri.parse("google.com");
    return StreamBuilder(
      stream: getUrl(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          return Visibility(
            visible: _controller.value.isInitialized &&
                _controller.value.isPlaying &&
                _controller.value.position < _controller.value.duration,
            child: Container(
                height: 59,
                width: double.infinity,
                color: greyColor,
                child: Stack(children: [
                  VideoPlayer(_controller),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        color: backgroundUserColor,
                        child: Icon(
                          Icons.close,
                          color: primaryUserColor,
                        ),
                      ),
                    ],
                  )
                ])),
          );
        } else {
          return SizedBox();
        }
      },
    );
  }
}
