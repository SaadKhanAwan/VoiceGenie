import 'package:flutter/material.dart';
import 'package:zenithrabitai/utils/space.dart';

class MyAuthButton extends StatefulWidget {
  final String title;
  final VoidCallback onPress;
  const MyAuthButton({super.key, required this.title, required this.onPress});

  @override
  State<MyAuthButton> createState() => _MyAuthButtonState();
}

class _MyAuthButtonState extends State<MyAuthButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPress,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: Pixels.width(context, 15)),
        width: double.infinity,
        height: Pixels.height(context, 65),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xff9476C5),
              Color(0xffFFD2AD),
              Color.fromARGB(255, 190, 173, 160),
              Color(0xffFF6F0F),
            ],
            stops: [0.0, 0.4, 0.8, 2.0],
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 17),
        child: Center(
            child: Text(
          widget.title,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.w700, fontSize: 20),
        )),
      ),
    );
  }
}
