import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zenithrabitai/firebase_options.dart';
import 'package:zenithrabitai/view/screen/generatediscrivtion/discribtionresult.dart';
import 'package:zenithrabitai/viewmodel/controller/provider/chatbot/generatetext.dart';
import 'package:zenithrabitai/viewmodel/controller/provider/image_picker/image_picker.dart';
import 'package:zenithrabitai/viewmodel/controller/provider/speech_text/speech_text.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GenerateTextProvider()),
        ChangeNotifierProvider(create: (_) => MyImagePicker()),
        ChangeNotifierProvider(create: (_) => SpeachToTextProvider()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ZenithRabit Ai',
        // home: SignUpScreen(),
        home: DiscribtionRresult(),
      ),
    );
  }
}
