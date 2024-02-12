import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:video_player/video_player.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/rice.mp4');
    _initializeVideoPlayerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            FutureBuilder(
              future: _initializeVideoPlayerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return VideoPlayer(_controller);
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
            Align(
              alignment: Alignment(0, -0.95),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    SizedBox(width: 20),
                    Text(
                      'Shorts',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    SizedBox(width: 155),
                    Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    SizedBox(width: 20),
                    Icon(
                      Icons.photo_camera_outlined,
                      color: Colors.white,
                    ),
                    SizedBox(width: 20),
                    Icon(
                      Icons.more_vert,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: AnimatedOpacity(
                opacity: _visible ? 0 : 1,
                duration: const Duration(milliseconds: 1000),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.black),
                  width: 70,
                  height: 70,
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _visible = !_visible;
                          if (_controller.value.isPlaying) {
                            _controller.pause();
                          } else {
                            _controller.play();
                          }
                        });
                      },
                      child: Icon(
                        _controller.value.isPlaying
                            ? Icons.pause
                            : Icons.play_arrow,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  customIcon(Icons.thumb_up, '4.2M'),
                  customIcon(Icons.thumb_down, 'Dislike'),
                  customIcon(Icons.comment, '10k'),
                  customIcon(Icons.reply, 'Share'),
                  customIcon(Icons.autorenew_rounded, 'Remix'),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.asset(
                      'assets/arsenal_logo.jpeg',
                      width: 40,
                      height: 40,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  channelNameRow(context),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, top: 5),
                    child: Text(
                      'Declan Rice scores from long range! 🎯',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 18),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 15),
                    child: Row(
                      children: [
                        Icon(Icons.headphones, color: Colors.white),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Original Sound',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 17,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Container channelNameRow(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.6,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.asset(
              'assets/arsenal_logo.jpeg',
              width: 35,
              height: 35,
              fit: BoxFit.cover,
            ),
          ),
          Text(
            '@arsenal',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text(
              'Subscribe',
              style: TextStyle(color: Colors.black),
            ),
            style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.white),
              shape: MaterialStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  customIcon(IconData icon, String text) {
    return Column(
      children: [
        IconButton(
          onPressed: () {},
          icon: Icon(
            icon,
            color: Colors.white,
            size: 30,
          ),
        ),
        Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
        SizedBox(
          height: 15,
        )
      ],
    );
  }
}
