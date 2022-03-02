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
  final videoPlayerController = VideoPlayerController.network('https://news18bangla-lh.akamaihd.net/i/n18bangla_1@2289/index_4_av-p.m3u8?checkedby:iptvcat.com');
  late ChewieController chewieController = ChewieController(
    videoPlayerController: videoPlayerController,
    autoPlay: true,
    looping: true,
    showControls: false,
    aspectRatio: 16 / 9,
    fullScreenByDefault: true,
    allowFullScreen: true,
    autoInitialize: true,
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
  void dispose() {
    videoPlayerController.dispose();
    chewieController.dispose();
    chewieController.pause();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF294479),
      body: Container(
        child: Container(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 48, left: 20),
                          child: Text('All Channels', style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.w500)),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 48, left: 40),
                          child: TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(
                              Icons.arrow_back_ios_outlined,
                              size: 24,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 8.0),
                      width: MediaQuery.of(context).size.width / 3,
                      // height: MediaQuery.of(context).size.height,
                      // decoration: BoxDecoration(border: Border.all()),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: link.length,
                        itemBuilder: (BuildContext context, int index) {
                          return MaterialButton(
                            onPressed: () {
                              print(link[index]);
                              setState(() {
                                dispose();

                                chewieController = ChewieController(
                                  videoPlayerController: VideoPlayerController.network(link[index]),
                                  autoPlay: true,
                                  showControls: false,
                                  aspectRatio: 16 / 9,
                                  fullScreenByDefault: true,
                                  autoInitialize: true,
                                );
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(vertical: 2.0),
                              decoration: BoxDecoration(
                                color: Color(0xFF2a2652),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: ListTile(
                                trailing: Icon(Icons.live_tv, color: Colors.red),
                                title: Text(
                                  '${index + 1}. ${title[index].toString()}',
                                  style: TextStyle(color: Colors.white, fontSize: 14.0),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  padding: EdgeInsets.only(right: 16),
                  width: MediaQuery.of(context).size.width / 1.5,
                  child: Chewie(
                    controller: chewieController,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
