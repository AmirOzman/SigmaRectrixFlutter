import 'package:flutter/material.dart';
import 'package:odoo_rpc/odoo_rpc.dart';
import 'package:sigma_crm/screen/screen.dart';

class AppBarCustom extends StatelessWidget implements PreferredSizeWidget {
  final String tajuk;
  final bool automaticallyImplyLeading;
  final bool log;
  final double barHeight = 50.0;
  final OdooClient client;
  final OdooSession session;

  const AppBarCustom({
    Key? key,
    required this.tajuk,
    this.log = false,
    this.automaticallyImplyLeading = true,
    required this.client,
    required this.session,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double statusbarHeight = MediaQuery.of(context).padding.top;
    return AppBar(
      title: Container(
        padding: EdgeInsets.only(top: statusbarHeight),
        height: statusbarHeight + barHeight,
        child: Center(
          child: Text(
            tajuk,
            style: Theme.of(context)
                .textTheme
                .headline4!
                .copyWith(color: Colors.white),
          ),
        ),
      ),
      centerTitle: true,
      //FIXME tab tak keluar
      actions: [
        log
            ? IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () async {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LogOutScreen(client, session)),
                    (Route<dynamic> route) => false,
                  );
                  await client.destroySession();
                  client.close();
                  // logOutButton();
                },
              )
            : const Text("")
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);

  // logOutButton() {
  //   IconButton(
  //     icon: const Icon(Icons.logout_outlined),
  //     onPressed: () async {
  //       await client.destroySession();
  //       client.close();
  //     },
  //   );
  // }

  tabAppBar() {
    const Tab(
      icon: Icon(Icons.abc),
      text: 'unconfirmed',
    );
    const Tab(icon: Icon(Icons.abc), text: 'Potential');
  }

  appBarTab() {
    AppBar(
      title: Text(tajuk),
      centerTitle: true,
      actions: const [],
    );
  }
}
