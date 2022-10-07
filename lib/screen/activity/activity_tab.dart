import 'package:flutter/material.dart';
import 'package:sigma_crm/model/model.dart';
import 'package:sigma_crm/widget/widget.dart';

class ActivityTab extends StatelessWidget {
  final OdooClient client;
  final OdooSession session;
  const ActivityTab(this.client, this.session, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //TODO set size limit maybe
    return Container(
      child: Column(children: [
        TabBar(
          tabs: [
            Tab(
              child: Text(
                "Last Activity",
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    ?.copyWith(color: Colors.white),
              ),
            ),
            Tab(
              child: Text('Upcoming Activity',
                  style: Theme.of(context)
                      .textTheme
                      .headline4
                      ?.copyWith(color: Colors.white)),
            )
          ],
        ),
        DefaultTabController(
          initialIndex: 0,
          length: 2,
          child: TabBarView(
            children: [
              ActivityStream(
                client: client,
                session: session,
                direction: Axis.vertical,
                past: true,
                // filter: false,
                limit: 5,
                height: 0.17,
                width: 0.6,
                // filter: '>=',
              ),
              ActivityStream(
                  client: client,
                  session: session,
                  direction: Axis.vertical,
                  limit: 5,
                  height: 0.17,
                  width: 0.6)
            ],
          ),
        )
      ]),
    );
  }
}
