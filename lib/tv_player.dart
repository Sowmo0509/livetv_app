import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class TvPlayer extends StatefulWidget {
  const TvPlayer({Key? key}) : super(key: key);

  @override
  _TvPlayerState createState() => _TvPlayerState();
}

class _TvPlayerState extends State<TvPlayer> {
  ChewieController? _chewieController;
  String videoUrl = 'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4';

  @override
  void initState() {
    super.initState();
    _chewieController = ChewieController(
      videoPlayerController: VideoPlayerController.network(videoUrl),
      aspectRatio: 16 / 9,
      autoInitialize: true,
      autoPlay: true,
      looping: true,
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              errorMessage,
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.blue,
      width: MediaQuery.of(context).size.width / 2,
      height: MediaQuery.of(context).size.height / 2,
      child: _buildHeroWidgetContent(),
    );
  }

  Chewie _buildHeroWidgetContent() {
    return Chewie(
      controller: _chewieController!,
    );
  }
}
