// import 'package:flutter/material.dart';
// import 'package:motion_app/main.dart';

// class EmotionDetectionWeb extends StatefulWidget {
//   const EmotionDetectionWeb({super.key});

//   @override
//   State<EmotionDetectionWeb> createState() => _EmotionDetectionWebState();
// }

// class _EmotionDetectionWebState extends State<EmotionDetectionWeb> {
//   String _emotion = 'Loading...';

//   @override
//   void initState() {
//     super.initState();

//     registerEmotionCallback((emotion) {
//       setState(() => _emotion = emotion);
//     });

//     startEmotionDetection();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Web Emotion Detection')),
//       body: Column(
//         children: [
//           const SizedBox(height: 20),
//           const Text("Detected Emotion:", style: TextStyle(fontSize: 20)),
//           Text(_emotion, style: const TextStyle(fontSize: 32)),
//           const SizedBox(height: 20),
//           const Expanded(child: HtmlElementView(viewType: 'videoElement')),
//         ],
//       ),
//     );
//   }
// }
