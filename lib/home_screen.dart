import 'package:flutter/material.dart';
import 'package:livetv_demo/tv_channels.dart';
import 'package:device_apps/device_apps.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:android_intent/android_intent.dart';

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
              Image.network(imgUrl),
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
                            onPressed: () {
                              _openYoutube();
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

  void _openYoutube() {
    DeviceApps.openApp('com.google.android.youtube');
  }
}
