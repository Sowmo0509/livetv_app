import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:livetv_demo/channel_list_button.dart';
import 'package:livetv_demo/tv_player.dart';
import 'package:m3u_nullsafe/m3u_nullsafe.dart';
import 'package:http/http.dart' as http;
import 'package:video_player/video_player.dart';

class TvChannels extends StatefulWidget {
  @override
  _TvChannelsState createState() => _TvChannelsState();
}

class _TvChannelsState extends State<TvChannels> {
  Uri M3Url = Uri.parse('https://raw.githubusercontent.com/Sowmo0509/livetv_app/master/Bangladesh_1.iptvcat.com.m3u8');
  final videoPlayerController = VideoPlayerController.network('https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4');
  late ChewieController chewieController = ChewieController(
    videoPlayerController: videoPlayerController,
    autoPlay: true,
    looping: true,
  );
  List title = [];
  List link = [];
  String mainVideoUrlTv = '';
  String videoUrl = '';

  Future<void> getList() async {
    final response = await http.get(M3Url);
    final m3u = await M3uParser.parse(response.body);

    for (final entry in m3u) {
      // print('Title: ${entry.title} Link: ${entry.link} Logo: ${entry.attributes['tvg-logo']}');
      setState(() {
        title.add(entry.title);
        link.add(entry.link);
      });
    }
  }

  initPlayer() async {
    await videoPlayerController.initialize();
  }

  @override
  void initState() {
    super.initState();
    getList();
    initPlayer();
    print(title);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Row(
          children: [
            Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 3,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(border: Border.all()),
                  child: Container(
                    child: ListView.builder(
                      itemCount: link.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          child: MaterialButton(
                              onPressed: () {
                                setState(() {
                                  videoUrl = link[index];
                                });
                              },
                              child: ListTile(title: Text(title[index].toString()))),
                        );
                      },
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 1.5,
                  child: Chewie(
                    controller: chewieController.copyWith(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
