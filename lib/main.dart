import 'package:flutter/material.dart';
import 'package:js/js.dart';
import 'package:web/web.dart' as web;
import 'dart:ui_web' as ui;

// JS interop to start detection
@JS('startEmotionDetection')
external void startEmotionDetection();

// JS interop to receive emotion updates
@JS('updateEmotion')
external set _updateEmotion(Function callback);

// Register Dart callback for JS
void registerEmotionCallback(void Function(String) callback) {
  _updateEmotion = allowInterop((emotion) {
    print("Received emotion from JS: $emotion"); // Log emotion in Dart
    callback(emotion); // Call Dart function
  });
}

void main() {
  // Register the video element for embedding in Flutter Web
  ui.platformViewRegistry.registerViewFactory('videoElement', (int viewId) {
    final video =
        web.HTMLVideoElement()
          ..id = 'video'
          ..autoplay = true
          ..muted = true
          ..style.width = '100%'
          ..style.height = '100%';
    return video;
  });

  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Emotion Detection Web',
      home: EmotionDetectionWeb(),
    ),
  );
}

class EmotionDetectionWeb extends StatefulWidget {
  const EmotionDetectionWeb({super.key});

  @override
  State<EmotionDetectionWeb> createState() => _EmotionDetectionWebState();
}

class _EmotionDetectionWebState extends State<EmotionDetectionWeb> {
  String _emotion = 'Initializing...';

  @override
  void initState() {
    super.initState();

    registerEmotionCallback((emotion) {
      setState(() => _emotion = emotion);
    });

    // Delay JS call slightly to ensure video element is in the DOM
    Future.delayed(const Duration(milliseconds: 500), () {
      startEmotionDetection();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Web Emotion Detection')),
      body: Column(
        children: [
          const SizedBox(height: 20),
          const Text("Detected Emotion:", style: TextStyle(fontSize: 20)),
          Text(_emotion, style: const TextStyle(fontSize: 32)),
          const SizedBox(height: 20),
          const SizedBox(
            height: 300,
            child: HtmlElementView(viewType: 'videoElement'),
          ),
        ],
      ),
    );
  }
}
