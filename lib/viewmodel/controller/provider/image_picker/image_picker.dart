import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class MyImagePicker with ChangeNotifier {
  File? _image;
  File? get image => _image;

  Future pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? photo = await picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      _image = File(photo.path);
      notifyListeners();
    }
  }

  void removeImage() {
    _image = null;
    notifyListeners();
  }
}
