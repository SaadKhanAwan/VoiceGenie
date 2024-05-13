import 'dart:developer';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:provider/provider.dart';
import 'package:zenithrabitai/viewmodel/controller/provider/chatbot/generatetext.dart';

class ChatBotText {
  static Future generateText(controller, context) async {
    final chatDataProvider =
        Provider.of<GenerateTextProvider>(context, listen: false);
    try {
      chatDataProvider.addMessage(true, controller, null);
      const apiKey = "AIzaSyAllFNB1dRb_OwmMdXWutkXW5BVkOP5MLM";
      final model = GenerativeModel(model: 'gemini-pro', apiKey: apiKey);
      final prompt = controller;

      final content = [Content.text(prompt)];
      final response = await model.generateContent(content);
      chatDataProvider.addMessage(false, response.text.toString(), null);
    } catch (e) {
      log("error is... $e");
    }
  }
}
