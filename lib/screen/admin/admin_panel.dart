import 'package:flutter/material.dart';
import 'package:odoo_rpc/odoo_rpc.dart';
import 'package:sigma_crm/widget/appbar/sliver_appbar.dart';

class AdminPanel extends StatelessWidget {
  final OdooClient client;
  final OdooSession session;
  const AdminPanel(this.client, this.session, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBarCustom(
            client: client,
            session: session,
            tajuk: Text('Admin Panel'),
            float: false,
            log: false,
            find: false,
          )
        ],
      ),
    );
  }
}
