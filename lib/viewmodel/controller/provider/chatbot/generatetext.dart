import 'package:flutter/cupertino.dart';
import 'package:zenithrabitai/model/chatbot_model.dart';

class GenerateTextProvider with ChangeNotifier {
  final List<ChatBotModel> _mytext = [];
  List<ChatBotModel> get mylist => _mytext;

  void addMessage(bool istrue, text, image) {
    _mytext.add(ChatBotModel(istrue: istrue, text: text, image: image));
    notifyListeners();
  }
}
