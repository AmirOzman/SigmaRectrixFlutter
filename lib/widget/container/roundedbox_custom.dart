import 'package:flutter/material.dart';

class RoundedBox extends StatelessWidget {
  final Color? warna;
  // List<Color> color=[];
  // final double radius;
  final Widget? child;
  final double h;
  final double w;
  final BorderRadius? rad;
  final bool roundAll;
  const RoundedBox(
      {Key? key,
      this.warna,
      required this.h,
      required this.w,
      required this.child,
      required this.roundAll,
      this.rad})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Container(
      height: h * screenSize.height,
      width: w * screenSize.width,
      decoration: BoxDecoration(
          color: warna ?? Colors.white,
          borderRadius: roundAll ? allSides() : top()),
      child: child,
    );
  }

  BorderRadius allSides() => BorderRadius.circular(20.0);

  BorderRadius top() => const BorderRadius.only(
      topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0));
}
