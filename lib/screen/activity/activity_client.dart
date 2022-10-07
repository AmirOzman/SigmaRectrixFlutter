// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:sigma_crm/model/stream/activity/activity_stream.dart';
import 'package:sigma_crm/widget/widget.dart';

class ActivityClient extends StatefulWidget {
  final OdooClient client;
  final OdooSession session;
  const ActivityClient(this.client, this.session, {Key? key}) : super(key: key);

  @override
  State<ActivityClient> createState() => _ActivityClientState();
}

class _ActivityClientState extends State<ActivityClient> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBarCustom(
            client: widget.client,
            session: widget.session,
            tajuk: const Text('Future Activities'),
            float: true,
            log: true,
            find: false,
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
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
                        child: ActivityStream(
                          client: widget.client,
                          session: widget.session,
                          direction: Axis.vertical,
                          // filter: false,
                          limit: 5,
                          height: 0.17,
                          width: 0.6,
                          // filter: '>=',
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
