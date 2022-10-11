import 'package:flutter/material.dart';

class ButtonIcon extends StatelessWidget {
  final String nama;
  final VoidCallback onPressed;
  final Color? warna;
  final Icon icon;
  const ButtonIcon(
      {Key? key,
      required this.nama,
      required this.onPressed,
      this.warna,
      required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: icon,
      label: Text(nama),
      style: ElevatedButton.styleFrom(
        backgroundColor: warna ?? Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
