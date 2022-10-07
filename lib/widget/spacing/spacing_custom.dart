import 'package:flutter/material.dart';

class SpacingAll extends StatelessWidget {
  final double h;
  final double w;
  const SpacingAll({Key? key, required this.h, required this.w})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SizedBox(
      width: w * screenSize.width,
      height: h * screenSize.height,
    );
  }
}

class SpacingH extends StatelessWidget {
  final double h;

  const SpacingH({Key? key, required this.h}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return SizedBox(
      height: h * height,
    );
  }
}

class SpacingW extends StatelessWidget {
  final double w;

  const SpacingW({Key? key, required this.w}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final swidth = MediaQuery.of(context).size.width;
    return SizedBox(
      width: w * swidth,
    );
  }
}
