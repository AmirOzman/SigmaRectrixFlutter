import 'package:flutter/material.dart';
import 'package:sigma_crm/model/stream/activity/activity_stream.dart';
import 'package:sigma_crm/widget/widget.dart';

class ClientFuture extends StatefulWidget {
  final OdooClient client;
  final OdooSession session;
  final int customerID;
  final String customerName;
  const ClientFuture(this.client, this.session,
      {Key? key, required this.customerID, required this.customerName})
      : super(key: key);

  @override
  State<ClientFuture> createState() => _ClientFutureState();
}

class _ClientFutureState extends State<ClientFuture> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // SliverAppBarCustom(
          //     client: widget.client,
          //     session: widget.session,
          //     tajuk: const Text('Future activities'),
          //     float: false,
          //     log: true,
          //     find: false),
          SliverList(
              delegate: SliverChildListDelegate(
            [
              PaddingCustom(
                h: 0.01,
                w: 0.05,
                child: Column(children: [
                  ActivityStream(
                      client: widget.client,
                      session: widget.session,
                      direction: Axis.vertical,
                      // filter: true,
                      limit: 100,
                      height: 0.16,
                      width: 0.8)
                ]),
              ),
            ],
          ))
        ],
      ),
    );
  }
}
