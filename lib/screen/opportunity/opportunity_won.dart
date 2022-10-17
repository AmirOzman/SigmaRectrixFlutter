import 'package:flutter/material.dart';
import 'package:sigma_crm/widget/widget.dart';
import 'package:sigma_crm/api/api.dart';

class OpportunityWon extends StatefulWidget {
  final OdooClient client;
  final OdooSession session;
  const OpportunityWon(this.client, this.session, {Key? key}) : super(key: key);

  @override
  State<OpportunityWon> createState() => _OpportunityWonState();
}

class _OpportunityWonState extends State<OpportunityWon> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // ignore: todo
          //TODO maybe replace sliverlist to sliverfixedextentlist
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
                        child: OpportunityStream(
                          client: widget.client,
                          session: widget.session,
                          direction: Axis.vertical,
                          height: 0.16,
                          width: 0.8,
                          limit: 80,
                          filter: 4, //diagnose
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
