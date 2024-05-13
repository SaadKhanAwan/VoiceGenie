import 'dart:io';

class ChatBotModel {
  final bool istrue;
  final String? text;
  final File? image;

  ChatBotModel({
    required this.istrue,
    this.text,
    this.image,
  });
}
