import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:tataclassedgeassignment/pages/quiz_page.dart';
import 'package:tataclassedgeassignment/utility/fadepageroute.dart';
import 'package:video_player/video_player.dart';
import 'package:velocity_x/velocity_x.dart';

class VideoPlayer extends StatefulWidget {
  const VideoPlayer({
    Key? key,
    this.title = 'Chewie Demo',
  }) : super(key: key);

  final String title;

  @override
  State<StatefulWidget> createState() {
    return _ChewieDemoState();
  }
}

class _ChewieDemoState extends State<VideoPlayer> {
  TargetPlatform? _platform;
  late VideoPlayerController _videoPlayerController1;
  // late VideoPlayerController _videoPlayerController2;
  ChewieController? _chewieController;
  @override
  void initState() {
    super.initState();
    initializePlayer();
    _videoPlayerController1.addListener(() {
      if (_videoPlayerController1.value.position ==
          _videoPlayerController1.value.duration) {
        print('video Ended');
        // Navigator.push(context, FadePageRoute(const VideoPlayer()));
        Navigator.push(
            context, MaterialPageRoute(builder: (context) =>  QuizPage()));
      }
    });
  }

  @override
  void dispose() {
    _videoPlayerController1.dispose();
    // _videoPlayerController2.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  Future<void> initializePlayer() async {
    _videoPlayerController1 = VideoPlayerController.network(
        'https://assets.mixkit.co/videos/preview/mixkit-a-girl-blowing-a-bubble-gum-at-an-amusement-park-1226-large.mp4');
    await Future.wait([
      _videoPlayerController1.initialize(),
      // _videoPlayerController2.initialize()
    ]);
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController1,
      autoPlay: true,
      looping: false,
      subtitle: Subtitles([
        Subtitle(
          index: 0,
          start: const Duration(seconds: 5),
          end: const Duration(seconds: 8),
          text: 'Whats up? :)',
        ),
      ]),
      subtitleBuilder: (context, subtitle) => Container(
        padding: const EdgeInsets.all(5.0),
        child: Text(
          subtitle,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      // Try playing around with some of these other options:
      showControls: false,
      materialProgressColors: ChewieProgressColors(
        playedColor: Colors.red,
        handleColor: Colors.blue,
        backgroundColor: Colors.transparent,
        bufferedColor: Colors.lightGreen,
      ),
      placeholder: Container(color: Colors.transparent),
      autoInitialize: true,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: "Video".text.xl4.make(),
      ),
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Colors.deepPurple,
            Colors.purple,
            Colors.redAccent,
          ],
        )),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Center(
                child: _chewieController != null &&
                        _chewieController!
                            .videoPlayerController.value.isInitialized
                    ? Chewie(
                        controller: _chewieController!,
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          CircularProgressIndicator(),
                          // SizedBox(height: 20),
                          Text('Loading'),
                        ],
                      ),
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        _chewieController?.dispose();
                        _videoPlayerController1.pause();
                        _videoPlayerController1.seekTo(const Duration());
                        _chewieController = ChewieController(
                          videoPlayerController: _videoPlayerController1,
                          autoPlay: true,
                          looping: false,
                          subtitleBuilder: (context, subtitle) => Container(
                            padding: const EdgeInsets.all(0.0),
                            child: Text(
                              subtitle,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        );
                      });
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 0.0),
                      // child: Text("Larndscape Video"),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
