import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CopyIt {
  static void copyToClipboard({textToCopy, context}) {
    Clipboard.setData(ClipboardData(text: textToCopy));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Text copied to clipboard!'),
      ),
    );
  }
}
