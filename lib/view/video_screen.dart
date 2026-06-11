import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoScreen extends StatefulWidget {
  final String videoUrl;

  const VideoScreen({super.key, required this.videoUrl});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late YoutubePlayerController _controller;
  bool _isPlayerReady = false;
  String? _videoId;

  @override
  void initState() {
    super.initState();

    _videoId = YoutubePlayer.convertUrlToId(widget.videoUrl);

    _controller = YoutubePlayerController(
      initialVideoId: _videoId ?? '',
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    )..addListener(_videoPlayerSystemStateListener);
  }

  void _videoPlayerSystemStateListener() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void deactivate() {
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.removeListener(_videoPlayerSystemStateListener);
    _controller.dispose();
    _resetDeviceDeviceSystemUIProperties();
    super.dispose();
  }

  void _resetDeviceDeviceSystemUIProperties() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_videoId == null || _videoId!.isEmpty) {
      return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: const Center(
          child: Text(
            "Invalid Tutorial Video Link",
            style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      );
    }


    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) {
        _resetDeviceDeviceSystemUIProperties();
      },
      child: YoutubePlayerBuilder(
        onExitFullScreen: () {
          _resetDeviceDeviceSystemUIProperties();
        },
        player: YoutubePlayer(
          controller: _controller,
          showVideoProgressIndicator: true,
          progressIndicatorColor: const Color(0xFFCCFF00),
          progressColors: const ProgressBarColors(
            playedColor: Color(0xFFCCFF00),
            handleColor: Color(0xFFCCFF00),
          ),
          onReady: () {
            _isPlayerReady = true;
          },
          onEnded: (data) {
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Tutorial Training Completed!"),
                  backgroundColor: Color(0xFF161616),
                ),
              );
            }
          },
        ),
        builder: (context, player) {
          return Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              backgroundColor: const Color(0xFF0E0E0E),
              elevation: 0,
              title: const Text(
                "VIDEO TUTORIAL",
                style: TextStyle(
                  color: Color(0xFFCCFF00),
                  fontWeight: FontWeight.w900,
                  fontSize: 14,
                  letterSpacing: 1,
                ),
              ),
              centerTitle: true,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  _resetDeviceDeviceSystemUIProperties();
                  Navigator.pop(context);
                },
              ),
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Embeds the responsive media stream directly
                    player,
                    const SizedBox(height: 24),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Text(
                        _controller.metadata.title.isNotEmpty
                            ? _controller.metadata.title
                            : "Fetching Video Title Data...",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Text(
                        _controller.metadata.author.isNotEmpty
                            ? "Coach/Author: ${_controller.metadata.author}"
                            : "",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}