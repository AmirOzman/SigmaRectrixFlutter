// ignore_for_file: unnecessary_import

import 'package:flutter/material.dart';
import 'package:sigma_crm/screen/admin/admin_panel.dart';
import 'package:sigma_crm/widget/widget.dart';
import 'package:sigma_crm/screen/screen.dart';

class DrawerCustom extends StatelessWidget {
  final OdooClient client;
  final OdooSession session;
  const DrawerCustom(
    this.client,
    this.session, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHead(),
          // const Divider(),
          if (session.userId == 1)
            DrawerItem(
                title: 'Admin dashboard',
                navigate: AdminPanel(
                  client,
                  session,
                )),

          const Divider(),
          DrawerItem(
            title: 'About Us',
            icon: Icons.info_outline,
            navigate: AboutUs(client: client, session: session),
          ),
          const Divider(),

          // DrawerItem(
          //   title: 'Product Catalog',
          //   navigate: Product(client, session),
          // ),
          // const Divider(),
          // DrawerItem(
          //     title: 'Product Variant',
          //     navigate: ProductVariant(client, session)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // const Divider(),
              // Spacer(),
              // DrawerItem(
              //   title: 'Admin Panel',
              //   icon: Icons.settings,
              //   navigate: ProductVariant(client, session),
              // ),
              // const Divider(),
            ],
          ),
        ],
      ),
    );
  }
}
