import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:livetv_demo/tv_player.dart';
import 'package:video_player/video_player.dart';

class TvChannels extends StatefulWidget {
  @override
  _TvChannelsState createState() => _TvChannelsState();
}

class _TvChannelsState extends State<TvChannels> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Container(
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.only(left: 0.0, top: 48.0),
              width: MediaQuery.of(context).size.width / 3,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(border: Border.all()),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 48.0),
                margin: EdgeInsets.symmetric(horizontal: 32.0, vertical: 48.0),
                child: ListView(
                  children: [
                    ListTile(
                      title: Text('Channel 1'),
                    ),
                    ListTile(
                      title: Text('Channel 1'),
                    ),
                    ListTile(
                      title: Text('Channel 1'),
                    ),
                    ListTile(
                      title: Text('Channel 1'),
                    ),
                    ListTile(
                      title: Text('Channel 1'),
                    ),
                    ListTile(
                      title: Text('Channel 1'),
                    ),
                    ListTile(
                      title: Text('Channel 1'),
                    ),
                    ListTile(
                      title: Text('Channel 1'),
                    ),
                    ListTile(
                      title: Text('Channel 1'),
                    ),
                    ListTile(
                      title: Text('Channel 1'),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                // color: Colors.blue,
                width: MediaQuery.of(context).size.width / 2,
                height: MediaQuery.of(context).size.height / 2,
                child: TvPlayer(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
