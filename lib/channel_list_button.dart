import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:livetv_demo/tv_channels.dart';
import 'dart:io';
import 'package:m3u_nullsafe/m3u_nullsafe.dart';
import 'package:http/http.dart' as http;
import 'package:video_player/video_player.dart';

class ChannelListButton extends StatefulWidget {
  const ChannelListButton({Key? key}) : super(key: key);

  @override
  _ChannelListButtonState createState() => _ChannelListButtonState();
}

class _ChannelListButtonState extends State<ChannelListButton> {
  // Uri M3Url = Uri.parse('https://iptv-org.github.io/iptv/languages/tha.m3u');
  Uri M3Url = Uri.parse('https://raw.githubusercontent.com/Sowmo0509/livetv_app/master/Bangladesh_1.iptvcat.com.m3u8');

  List title = [];
  List link = [];
  String mainVideoUrlTv = '';

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

  @override
  void initState() {
    super.initState();
    getList();
    print(title);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          ListView.builder(
            itemCount: link.length,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: [
                  MaterialButton(
                      onPressed: () {
                        setState(() {});
                      },
                      child: ListTile(title: Text(title[index].toString()))),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
