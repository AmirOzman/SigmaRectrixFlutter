import 'package:flutter/material.dart';
import 'package:sigma_crm/widget/widget.dart';
import 'package:sigma_crm/api/api.dart';

class OpportunityLost extends StatefulWidget {
  final OdooClient client;
  final OdooSession session;
  const OpportunityLost(this.client, this.session, {Key? key})
      : super(key: key);

  @override
  State<OpportunityLost> createState() => _OpportunityLostState();
}

class _OpportunityLostState extends State<OpportunityLost> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
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
                      child: LostStream(
                        client: widget.client,
                        direction: Axis.vertical,
                        height: 0.16,
                        width: 0.8,
                        limit: 1000,
                        filter: 11,
                        // lost: false, //lost
                      ),
                    )
                  ],
                ),
              ),
            ],
          ))
        ],
      ),
    );
  }
}
