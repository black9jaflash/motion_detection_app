# Motion App – Real-Time Emotion Detection in Flutter Web

This Flutter web app uses a webcam to detect human facial expressions (like happy, sad, angry, etc.) in real time using `face-api.js` through JavaScript interop.

## 🧠 Features

- Real-time facial emotion detection via webcam
- Face detection using `TinyFaceDetector`
- Emotion classification using `FaceExpressionNet`
- Live integration with Flutter UI
- JavaScript interop with Dart
- Hosted on Netlify

## 🚀 Demo

👉 **Live Preview**: [https://motion-ai-web.netlify.app/](https://motion-ai-web.netlify.app/)

## 📸 How It Works

1. The app requests camera access from the user.
2. It uses `face-api.js` to detect a face and read facial expressions.
3. The dominant emotion (e.g., happy, angry, surprised) is extracted.
4. Detected emotion is passed to Flutter via JS interop and shown in the UI.

## 📁 Project Structure

motion_app/

├── web/

│ ├── index.html

│ ├── emotion.js

│ └── models/ # contains TinyFaceDetector and FaceExpressionNet weights

├── lib/

│ └── main.dart

├── pubspec.yaml

├── README.md

└── ...
