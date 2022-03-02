import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:flutter/material.dart';
import 'package:livetv_demo/channel_list_button.dart';
import 'package:livetv_demo/tv_channels.dart';
// import 'package:external_app_launcher/external_app_launcher.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String imgUrl = 'https://cdn.wallpapersafari.com/43/95/7MrGBn.jpg';
  FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Stack(
            children: [
              Image.network(imgUrl, fit: BoxFit.cover, width: MediaQuery.of(context).size.width),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 240.0, vertical: 32.0),
                  width: MediaQuery.of(context).size.width,
                  height: 56.0,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: Colors.yellow[200]),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 64.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => TvChannels()));
                            },
                            child: Icon(Icons.tv, size: 32)),
                        TextButton(
                            onPressed: () async {
                              await LaunchApp.openApp(
                                androidPackageName: 'com.google.android.youtube.tv',
                                openStore: false,
                              );
                            },
                            child: Icon(Icons.smart_display, size: 32)),
                        TextButton(onPressed: () {}, child: Icon(Icons.cast, size: 32)),
                      ],
                    ),
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
