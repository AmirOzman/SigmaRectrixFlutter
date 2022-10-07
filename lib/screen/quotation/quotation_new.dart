import 'package:flutter/material.dart';
import 'package:sigma_crm/widget/widget.dart';

class QuotationNew extends StatefulWidget {
  final OdooClient client;
  final OdooSession session;
  const QuotationNew(this.client, this.session, {Key? key}) : super(key: key);

  @override
  State<QuotationNew> createState() => _QuotationNewState();
}

class _QuotationNewState extends State<QuotationNew> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBarCustom(
            client: widget.client,
            session: widget.session,
            tajuk: const Text('Quotation'),
            float: true,
            log: true,
            find: true,
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            PaddingCustom(
              h: 0.01,
              w: 0.05,
              child: Column(
                children: const [
                  RoundedBox(
                      warna: Colors.transparent,
                      h: 0.8,
                      w: 1,
                      roundAll: true,
                      child: Text('unable to retrieve data')
                      // OpportunityStream(
                      //   client: widget.client,
                      //   direction: Axis.vertical,
                      //   height: 0.16,
                      //   width: 0.8,
                      //   limit: 80,
                      // ),
                      ),
                ],
              ),
            ),
          ]))
        ],
        // child: PaddingConst(child: Column(children: [])),
      ),
    );
  }
}
