import 'package:flutter/material.dart';
import 'package:music_player/providers/user_provider.dart';
import 'package:music_player/shared/theme.dart';
import 'package:provider/provider.dart';

enum ImageType { audio, playlist, gallery, player }

class DefaultImage extends StatelessWidget {
  const DefaultImage({required this.type, this.size = 0, super.key});

  final double size;

  final ImageType type;

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);

    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(type == ImageType.player
            ? 32
            : type == ImageType.audio
                ? 8
                : 4),
        color: userProvider.user.role == "USER"
            ? const Color.fromARGB(255, 58, 58, 58)
            : const Color.fromARGB(255, 223, 223, 223),
      ),
      child: Icon(
        type == ImageType.playlist
            ? Icons.library_music
            : type == ImageType.gallery
                ? Icons.photo_library
                : Icons.music_note,
        size: size * 0.5,
        color: userProvider.user.role == "USER" ? greyColor : Colors.white,
      ),
    );
  }
}
