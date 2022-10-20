import 'package:flutter/material.dart';
import 'package:sigma_crm/config/theme/theme.dart';
import 'package:sigma_crm/screen/opportunity/opportunity.dart';
import 'package:sigma_crm/screen/screen.dart';
import 'package:sigma_crm/widget/widget.dart';

class OpportunityView extends StatefulWidget {
  final OdooClient client;
  final OdooSession session;
  // final String userAvatar;
  const OpportunityView(this.client, this.session,
      //  this.userAvatar,
      {Key? key})
      : super(key: key);

  @override
  State<OpportunityView> createState() => _OpportunityViewState();
}

class _OpportunityViewState extends State<OpportunityView> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => showExitPopup(context),
      child: Scaffold(
        body: DefaultTabController(
          initialIndex: 0,
          length: 8,
          child: CustomScrollView(slivers: [
            SliverAppBarCustom(
              client: widget.client,
              session: widget.session,
              tajuk: Text(
                'Opportunity',
                style: Theme.of(context).textTheme.headline4,
              ),
              // tajuk: switch(pageNumber){case 0:Text('Lost');break;},
              float: true,
              log: true,
              find: false,
              bottom: TabBar(
                unselectedLabelColor: Colors.white,
                labelColor: COLOR_4,
                indicator: BoxDecoration(
                  color: COLOR_3,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                isScrollable: true,
                tabs: [
                  Tab(
                    child: Text(
                      'New',
                      style: Theme.of(context)
                          .textTheme
                          .headline5
                          ?.copyWith(color: Colors.white),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Lost',
                      style: Theme.of(context)
                          .textTheme
                          .headline5
                          ?.copyWith(color: Colors.white),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'No Budget',
                      style: Theme.of(context)
                          .textTheme
                          .headline5
                          ?.copyWith(color: Colors.white),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Diagnose',
                      style: Theme.of(context)
                          .textTheme
                          .headline5
                          ?.copyWith(color: Colors.white),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Proposition',
                      style: Theme.of(context)
                          .textTheme
                          .headline5
                          ?.copyWith(color: Colors.white),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'SebutHarga',
                      style: Theme.of(context)
                          .textTheme
                          .headline5
                          ?.copyWith(color: Colors.white),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Tender',
                      style: Theme.of(context)
                          .textTheme
                          .headline5
                          ?.copyWith(color: Colors.white),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Won',
                      style: Theme.of(context).textTheme.headline5?.copyWith(
                            color: Colors.white,
                          ),
                    ),
                  ),
                ],
              ),
            ),
            SliverFillRemaining(
              child: RoundedBox(
                h: 0.7,
                w: 1,
                warna: Colors.blue,
                roundAll: true,
                child: TabBarView(children: [
                  OpportunityNew(widget.client, widget.session),
                  OpportunityLost(widget.client, widget.session),
                  OpportunityNoBudget(widget.client, widget.session),
                  OpportunityDiagnose(widget.client, widget.session),
                  OpportunityProposisiotn(widget.client, widget.session),
                  OpportunitySebutHarga(widget.client, widget.session),
                  OpportunityTender(widget.client, widget.session),
                  OpportunityWon(widget.client, widget.session),
                ]),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
