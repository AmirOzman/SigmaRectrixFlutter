import 'package:flutter/material.dart';

class PaddingConst extends StatelessWidget {
  final Widget? child;
  const PaddingConst({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    final screenWidth = screenSize.width;
    return Padding(
      //edit padding size untuk activity ngan lain. jarak atas jauh sangatw
      padding: EdgeInsets.symmetric(
        vertical: screenHeight * 0.04,
        horizontal: screenWidth * 0.04,
      ),
      child: child,
    );
  }
}

class PaddingCustom extends StatelessWidget {
  final Widget? child;
  final double h;
  final double w;
  const PaddingCustom({
    Key? key,
    required this.h,
    required this.w,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    final screenWidth = screenSize.width;
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: h * screenHeight, horizontal: w * screenWidth),
      child: child,
    );
  }
}
