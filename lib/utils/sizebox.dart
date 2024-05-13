import 'package:flutter/material.dart';
import 'package:zenithrabitai/utils/space.dart';

class HorizantalSizeBox extends StatelessWidget {
  final double? width;
  const HorizantalSizeBox({super.key, required this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Pixels.width(context, width ?? 18),
    );
  }
}

class VerticalSizeBox extends StatelessWidget {
  final double? height;
  const VerticalSizeBox({super.key, this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Pixels.height(context, height ?? 18),
    );
  }
}
