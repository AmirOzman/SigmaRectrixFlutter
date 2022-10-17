// ignore_for_file: unnecessary_import

import 'package:flutter/material.dart';

import 'package:sigma_crm/widget/widget.dart';

class DrawerItem extends StatelessWidget {
  final IconData? icon;
  final String title;

  final Widget navigate;
  const DrawerItem(
      {Key? key, this.icon, required this.title, required this.navigate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => navigate));

        // context, MaterialPageRoute(builder: (context) => widget));
      },
    );
  }
}
