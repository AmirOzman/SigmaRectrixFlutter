import 'package:flutter/material.dart';
import 'package:sigma_crm/widget/widget.dart';
import 'package:sigma_crm/api/api.dart';

class OpportunityProposisiotn extends StatefulWidget {
  final OdooClient client;
  final OdooSession session;
  const OpportunityProposisiotn(this.client, this.session, {Key? key})
      : super(key: key);

  @override
  State<OpportunityProposisiotn> createState() =>
      _OpportunityProposisiotnState();
}

class _OpportunityProposisiotnState extends State<OpportunityProposisiotn> {
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
