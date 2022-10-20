import 'package:flutter/material.dart';
import 'package:sigma_crm/widget/widget.dart';
import 'package:sigma_crm/api/api.dart';

class OpportunityNew extends StatefulWidget {
  final OdooClient client;
  final OdooSession session;
  // final OdooModel model;
  const OpportunityNew(this.client, this.session, {Key? key}) : super(key: key);

  @override
  State<OpportunityNew> createState() => _OpportunityNewState();
}

class _OpportunityNewState extends State<OpportunityNew> {
  Future<dynamic> fetchOpportnity() {
    return widget.client.callKw({
      'model': 'crm.lead',
    });
  }

  final find = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // final model = OdooModel(className: className, tableName: crm_leads, columns: columns);
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
                          filter: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                // Container(
                //   height: screenSize.height * 2,
                //   decoration: const BoxDecoration(color: Colors.red),
                // )
              ],
            ),
          ),
        ],
        // Center(child: Column(children: const [Text("Sales Opportunity")])),
      ),
    );
  }
}
