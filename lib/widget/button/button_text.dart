import 'package:flutter/material.dart';

class ButtonText extends StatelessWidget {
  final double lebar;
  final String nama;
  final VoidCallback onPressed;
  final Color? warna;
  // final Widget? navigate;
  const ButtonText(
      {Key? key,
      required this.nama,
      required this.lebar,
      required this.onPressed,
      // this.navigate,
      this.warna})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size.width;
    return SizedBox(
      width: lebar * screenSize,
      child: PhysicalModel(
        color: Colors.transparent,
        elevation: 8.0,
        shape: BoxShape.rectangle,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: warna ?? Colors.black,
              // primary: Colors.black,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0))),
          onPressed: onPressed,
          child: Text(nama),
        ),
      ),
    );
  }
}
