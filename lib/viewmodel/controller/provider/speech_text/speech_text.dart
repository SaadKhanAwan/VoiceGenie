import 'package:flutter/cupertino.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SpeachToTextProvider with ChangeNotifier {
  bool _recordingStart = false;
  bool get recordingStart => _recordingStart;

  SpeechToText speechToText = SpeechToText();

  void initSpeech() async {
    await speechToText.initialize();
    notifyListeners();
  }

  Future<void> startListening(
      {required TextEditingController controller}) async {
    await speechToText.listen(onResult: (SpeechRecognitionResult result) {
      controller.text = result.recognizedWords;
    });
    _recordingStart = true;
    notifyListeners();
  }

  Future<void> stopListening() async {
    await speechToText.stop();

    _recordingStart = false;
    notifyListeners();
  }
}
