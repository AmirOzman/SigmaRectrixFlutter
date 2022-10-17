// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:sigma_crm/model/model.dart';
import 'package:sigma_crm/widget/widget.dart';
import 'package:sigma_crm/api/api.dart';

class LostLeads extends StatefulWidget {
  final OdooClient client;
  final OdooSession session;

  const LostLeads(this.client, this.session, {Key? key}) : super(key: key);

  @override
  State<LostLeads> createState() => _LostLeadsState();
}

class _LostLeadsState extends State<LostLeads> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(slivers: [
        SliverAppBarCustom(
          client: widget.client,
          session: widget.session,
          tajuk: const Text('Lost'),
          float: true,
          log: true,
          find: false,
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            PaddingConst(
                child: Column(
              children: [
                RoundedBox(
                  h: 0.8,
                  w: 1,
                  roundAll: true,
                  child: DbStream(
                    client: widget.client,
                    direction: Axis.vertical,
                    limit: 80,
                    tableName: 'crm_lead',
                    fields: const [
                      'name',
                      '',
                      'create_uid',
                      'create_date',
                      'write_uid',
                      'write_date'
                    ],
                    filter: const [
                      ['active', '=', 'true']
                    ],
                    title: 'id',
                    subtitle: 'lost_reason_id',
                  ),
                )
              ],
            ))
          ]),
        )
      ]),
    );
  }
}
