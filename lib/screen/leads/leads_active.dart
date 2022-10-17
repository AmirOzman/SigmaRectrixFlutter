// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:sigma_crm/api/api.dart';
import 'package:sigma_crm/model/model.dart';
import 'package:sigma_crm/widget/widget.dart';

class SalesTable extends StatefulWidget {
  final OdooClient client;
  final OdooSession session;
  // final String userAvatar;
  const SalesTable(this.client, this.session,
      //  this.userAvatar,
      {Key? key})
      : super(key: key);

  @override
  State<SalesTable> createState() => _SalesTableState();
}

class _SalesTableState extends State<SalesTable> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: NewLeadButton(
        client: widget.client,
        session: widget.session,
      ),
      body: CustomScrollView(slivers: [
        SliverAppBarCustom(
            client: widget.client,
            session: widget.session,
            tajuk: Text('Leads', style: Theme.of(context).textTheme.headline3),
            float: true,
            log: true,
            find: true),
        // SliverPersistentHeader(delegate: SearchHeader(icon:Icons.terrain,title:'Leads',search:_Search(),)),
        SliverList(
            delegate: SliverChildListDelegate([
          PaddingCustom(
            h: 0.01,
            w: 0.05,
            child: Column(
              children: [
                RoundedBox(
                  warna: Colors.transparent,
                  h: 0.8,
                  w: 1,
                  roundAll: true,
                  child: LeadStream(
                    session: widget.session,
                    client: widget.client,
                    direction: Axis.vertical,
                    height: 0.10,
                    width: 0.8,
                    limit: 80,
                  ),
                ),
              ],
            ),
          ),
        ]))
      ]),
    );
  }
}
