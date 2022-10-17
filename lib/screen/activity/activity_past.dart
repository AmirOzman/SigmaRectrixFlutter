// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:sigma_crm/widget/widget.dart';
import 'package:sigma_crm/model/model.dart';

class ActivityPast extends StatefulWidget {
  final OdooClient client;
  final OdooSession session;
  final Widget customerName;
  final Widget customerID;
  const ActivityPast(
    this.client,
    this.session, {
    Key? key,
    required this.customerName,
    required this.customerID,
  }) : super(key: key);

  @override
  State<ActivityPast> createState() => _ActivityPastState();
}

class _ActivityPastState extends State<ActivityPast> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBarCustom(
            client: widget.client,
            session: widget.session,
            tajuk: widget.customerName,
            float: true,
            log: true,
            find: false,
            large: true,
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                PaddingConst(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        RoundedBox(
                          warna: Colors.transparent,
                          h: 0.20,
                          w: 1,
                          roundAll: true,
                          child: Column(
                            children: [
                              widget.customerID,
                              widget.customerName,
                              // ActivityStream(
                              //   client: widget.client,
                              //   direction: Axis.horizontal,
                              //   limit: 80,
                              //   height: 0.8,
                              //   width: 1,
                              // ),
                              // ignore: todo
                              //TODO show streams of previous activities
                            ],
                          ),
                          // child: Text(widget.customerID.toString()),
                          // child: CurrentActivityStream(
                          //   client: widget.client,
                          //   direction: Axis.horizontal,
                          //   limit: 80,
                          //   height: 0.8,
                          //   width: 1,
                          // ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
