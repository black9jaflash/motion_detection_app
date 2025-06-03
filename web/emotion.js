window.updateEmotion = null;

async function waitForVideoElement() {
  return new Promise((resolve) => {
    const check = () => {
      const video = document.getElementById('video');
      if (video) resolve(video);
      else setTimeout(check, 100); // Keep checking every 100ms
    };
    check();
  });
}

async function startEmotionDetection() {
  const video = await waitForVideoElement();

  try {
    const stream = await navigator.mediaDevices.getUserMedia({ video: true });
    video.srcObject = stream;
  } catch (err) {
    console.error("Camera access denied:", err);
    if (window.updateEmotion) {
      window.updateEmotion("Camera access denied");
    }
    return;
  }

  // Load models
  console.log("Loading models...");
  await faceapi.nets.tinyFaceDetector.loadFromUri('models');
  console.log("TinyFaceDetector loaded successfully!");
  await faceapi.nets.faceExpressionNet.loadFromUri('models');
  console.log("FaceExpressionNet loaded successfully!");

  // Wait for video metadata to ensure it's ready to play
  video.onloadedmetadata = () => {
    video.play().then(() => {
      console.log("Video playing. Starting detection...");
      detectEmotion(video);
    }).catch((err) => {
      console.error("video.play() failed:", err);
      if (window.updateEmotion) {
        window.updateEmotion("Video play error");
      }
    });
  };
}

function detectEmotion(video) {
  setInterval(async () => {
    console.log("Detecting face...");
    const detection = await faceapi
      .detectSingleFace(video, new faceapi.TinyFaceDetectorOptions())
      .withFaceExpressions();

    if (detection && detection.expressions) {
      const max = Object.entries(detection.expressions).reduce((a, b) =>
        a[1] > b[1] ? a : b
      );

      console.log("Detected emotion:", max[0]);
      if (window.updateEmotion) {
        window.updateEmotion(max[0]);
      }
    } else {
      console.log("No face detected");
      if (window.updateEmotion) {
        window.updateEmotion("No face detected");
      }
    }
  }, 1000); // Run detection every second
}
