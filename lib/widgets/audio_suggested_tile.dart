import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:music_player/providers/user_provider.dart';
import 'package:music_player/widgets/default_image.dart';
import 'package:provider/provider.dart';

import '../shared/theme.dart';

class AudioSuggestedTile extends StatelessWidget {
  const AudioSuggestedTile({
    Key? key,
    required this.title,
    this.coverUrl = '',
  }) : super(key: key);

  final String title;
  final String coverUrl;

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    return Container(
      margin: const EdgeInsets.only(right: 24),
      width: 120,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: coverUrl.isEmpty
                ? const DefaultImage(type: ImageType.audio, size: 120)
                : CachedNetworkImage(
                    imageUrl: coverUrl,
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                  ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style:
                (userProvider.user?.role == "USER" || userProvider.user == null
                        ? primaryUserColorText
                        : primaryAdminColorText)
                    .copyWith(fontSize: 12),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
