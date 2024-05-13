import 'package:flutter_tts/flutter_tts.dart';

class TextToAudio {
  static FlutterTts flutterTts = FlutterTts();
  static speak(String text) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1);
    await flutterTts.speak(text);
  }
}
