import 'package:flutter/material.dart';

class SpacingPixel extends StatelessWidget {
  final double? h;
  final double? w;
  const SpacingPixel({
    Key? key,
    this.h,
    this.w,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: h,
      width: w,
    );
  }
}
