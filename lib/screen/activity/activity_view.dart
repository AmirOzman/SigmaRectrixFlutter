// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:sigma_crm/widget/widget.dart';
import 'package:sigma_crm/screen/screen.dart';
import 'package:sigma_crm/model/model.dart';

import '../../config/theme/theme.dart';

class ActivityView extends StatefulWidget {
  final OdooClient client;
  final OdooSession session;
  // final int customerID;
  const ActivityView(
    this.client,
    this.session, {
    Key? key,
    // required this.customerID,
  }) : super(key: key);

  @override
  State<ActivityView> createState() => _ActivityViewState();
}

class _ActivityViewState extends State<ActivityView> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => showExitPopup(context),
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBarCustom(
              tajuk: Text(
                'Activities',
                style: Theme.of(context).textTheme.headline4,
              ),
              float: false,
              log: true,
              find: false,
              session: widget.session,
              client: widget.client,
            ),
            SliverFillRemaining(
              child: PaddingConst(
                  child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: COLOR_3,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15))),
                    height: 40,
                    width: double.infinity,
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        '\t\tFuture Activities',
                        style: Theme.of(context)
                            .textTheme
                            .headline1
                            ?.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                  SpacingVertical(10),
                  RoundedBox(
                    h: 0.25,
                    w: 1,
                    roundAll: true,
                    child: ActivityStream(
                      client: widget.client,
                      session: widget.session,
                      direction: Axis.horizontal,
                      limit: 50,
                      height: 0.15,
                      width: 0.6,
                      past: false,
                    ),
                  ),
                  SpacingVertical(20),
                  Container(
                    // color: COLOR_3,
                    height: 40,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: COLOR_3,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15))),
                    child: Text(
                      '\t\tPast Activities',
                      style: Theme.of(context)
                          .textTheme
                          .headline1
                          ?.copyWith(color: Colors.white),
                    ),
                  ),
                  SpacingVertical(10),
                  RoundedBox(
                    h: 0.25,
                    w: 1,
                    roundAll: true,
                    // child: TestStream(widget.client, widget.session,
                    //     direction: Axis.horizontal, height: 0.37, width: 1),
                    child: ActivityStream(
                      client: widget.client,
                      session: widget.session,
                      direction: Axis.horizontal,
                      limit: 50,
                      height: 0.15,
                      width: 0.6,
                      past: true,
                    ),
                    // child: Center(
                    //   child: Text('Future Activities'),
                    // ),
                  ),
                ],
              )),
            )
          ],
        ),
      ),
    );
  }
}
