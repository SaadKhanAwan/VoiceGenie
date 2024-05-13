import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:zenithrabitai/viewmodel/controller/provider/chatbot/generatetext.dart';

class ChatBotWithImage {
  static const String myapikey = "AIzaSyB70zASFRNLiV-O4IhRBbx6aJIXDsoJS-c";
  static const apiUrl =
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-pro-vision:generateContent?key=$myapikey';
  static const header = {
    'Content-Type': 'application/json',
  };

  static Future getdata(image, promptValue, context) async {
    final chatDataProvider =
        Provider.of<GenerateTextProvider>(context, listen: false);

    try {
      List<int> imageBytes = File(image.path).readAsBytesSync();
      String base64File = base64.encode(imageBytes);

      final data = {
        "contents": [
          {
            "parts": [
              {"text": promptValue},
              {
                "inlineData": {
                  "mimeType": "image/jpeg",
                  "data": base64File,
                }
              }
            ]
          }
        ],
      };

      await http
          .post(Uri.parse(apiUrl), headers: header, body: jsonEncode(data))
          .then((response) {
        if (response.statusCode == 200) {
          var result = jsonDecode(response.body);
          final mytext = result['candidates'][0]['content']['parts'][0]['text'];
          log(mytext);
          chatDataProvider.addMessage(false, mytext, null);
        } else {
          final mytext = 'Response status : ${response.statusCode}';
          log(mytext);
        }
      }).catchError((error) {
        log('Error occored $error');
      });
    } catch (e) {
      log('Error occured $e');
    }
  }
}
