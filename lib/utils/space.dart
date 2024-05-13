import 'package:flutter/material.dart';

class Pixels {
  // here this height is divided by 926 beecause //we are not giving height
  // in decimal numer we are give in // normal number then it will be divided
  //by 926 automaticall and converted to decimal .
  static height(BuildContext context, double height) {
    return (MediaQuery.of(context).size.height * height);
  }

  // Same is the case here
  static width(BuildContext context, double width) {
    return (MediaQuery.of(context).size.width * width);
  }
}
