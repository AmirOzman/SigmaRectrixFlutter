// ignore_for_file: unnecessary_import

import 'package:flutter/material.dart';
import 'package:sigma_crm/widget/widget.dart';

class Neumorphic extends StatelessWidget {
  const Neumorphic({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500.0,
      height: 500.0,
      color: const Color(0xffecf0f3),
      alignment: Alignment.center,
      transformAlignment: Alignment.center,
      child: Container(
        color: const Color(0xffecf0f3),
        child: Container(
          width: 124,
          height: 124,
          decoration: BoxDecoration(
            color: const Color(0xffecf0f3),
            borderRadius: BorderRadius.circular(15),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xffecf0f3),
                Color(0xffecf0f3),
              ],
            ),
            boxShadow: const [
              BoxShadow(
                color: Color(0xffffffff),
                offset: Offset(-12.8, -12.8),
                blurRadius: 51,
                spreadRadius: 0.0,
              ),
              BoxShadow(
                color: Color(0xffc4c8cb),
                offset: Offset(12.8, 12.8),
                blurRadius: 51,
                spreadRadius: 0.0,
              ),
            ],
          ),
          // child: const Icon(
          //   Icons.star,
          //   size: 41,
          //   color: Colors.amber,
          // ),
          child: const Icon(
            Icons.star,
            size: 41,
            color: Colors.amber,
          ),
        ),
      ),
    );
  }
}
