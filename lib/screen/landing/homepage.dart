import 'package:flutter/material.dart';
import 'package:sigma_crm/api/api.dart';
import 'package:sigma_crm/model/model.dart';
import 'package:sigma_crm/widget/widget.dart';

class HomeScreen extends StatefulWidget {
  final OdooClient client;
  final OdooSession session;
  // final String baseURL;

  const HomeScreen(
    this.client,
    this.session, {
    Key? key,
    // required this.baseURL,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    final avatarURL;

    print("this is widget session partner id" +
        widget.session.partnerId.toString());

    // ignore: unnecessary_null_comparison
    if (widget.session.partnerId != null) {
      avatarURL =
          '${widget.client.baseURL}/web/image?model=res.partner&id=${widget.session.partnerId}&field=image_medium';

      print("this is AVATARURL HOMEPAGE" + avatarURL.toString());
    } else
      (avatarURL = null);

    TabController activityTab = TabController(length: 2, vsync: this);
    return WillPopScope(
      onWillPop: () => showExitPopup(context),
      child: Scaffold(
        drawer: DrawerCustom(widget.client, widget.session),
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
                floating: true,
                expandedHeight: 120,
                flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    title: Text(
                      'Welcome\n${widget.session.userName}',
                      style: Theme.of(context)
                          .textTheme
                          .headline3
                          ?.copyWith(color: Colors.white54),
                    ))),
            SliverList(
              delegate: SliverChildListDelegate([
                // ignore: fixme
                //FIXME PaddingConst()
                SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          height: screenSize.height * 0.2,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: screenSize.width * 0.02),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Card(
                                          child: Align(
                                              alignment: Alignment.center,
                                              child: Column(
                                                children: [
                                                  // ignore: fixme
                                                  //FIXME Temporary.
                                                  Center(
                                                    child: Text(
                                                      'Reserve for OKR',
                                                      style: TextStyle(
                                                          fontStyle:
                                                              FontStyle.italic,
                                                          fontSize: 40),
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        flex: 3,
                                                        child: Container(
                                                          height: 20,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .only(
                                                              topLeft: Radius
                                                                  .circular(7),
                                                              bottomLeft: Radius
                                                                  .circular(7),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Container(
                                                          height: 20,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              )),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // ignore: todo
                                //TODO statistics untuk display success rate.

                                Expanded(
                                  flex: 1,
                                  child: Card(
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: SizedBox(
                                          width: double.infinity,
                                          height: double.infinity,
                                          child: avatarURL != null
                                              ? CircleAvatar(
                                                  onBackgroundImageError: null,
                                                  backgroundImage: NetworkImage(
                                                      avatarURL,
                                                      headers: {
                                                        "X-Openerp-Session-Id":
                                                            widget.client
                                                                .sessionId!.id
                                                      }))
                                              : CircleAvatar(
                                                  backgroundColor: Colors.black,
                                                )),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: screenSize.height * 0.6,
                          width: screenSize.width * 0.9,
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              // color: const Color(0xFFFDB777),
                              borderRadius: BorderRadius.circular(20.0)),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  const SpacingAll(h: 0.02, w: 0.8),
                                  // ignore: fixme
                                  //FIXME error controller length property(4) does not match the number of the tabs
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: TabBar(
                                      controller: activityTab,
                                      tabs: [
                                        Tab(
                                          child: Text(
                                            "Last Activity",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline4,
                                          ),
                                        ),
                                        Tab(
                                          child: Text('Upcoming Activity',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline4),
                                        )
                                      ],
                                    ),
                                  ),
                                  SpacingVertical(10),
                                  RoundedBox(
                                    warna: Colors.transparent,
                                    h: 0.30,
                                    w: 1,
                                    roundAll: true,
                                    child: TabBarView(
                                        controller: activityTab,
                                        children: [
                                          ActivityStream(
                                            client: widget.client,
                                            session: widget.session,
                                            direction: Axis.vertical,
                                            past: true,
                                            // filter: false,
                                            limit: 5,
                                            height: 0.17,
                                            width: 0.6,
                                            // filter: '>=',
                                          ),
                                          ActivityStream(
                                              client: widget.client,
                                              session: widget.session,
                                              direction: Axis.vertical,
                                              limit: 5,
                                              height: 0.17,
                                              width: 0.6)
                                        ]),
                                  ),
                                  const SpacingAll(h: 0.02, w: 0.8),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "Recent Leads",
                                      style:
                                          Theme.of(context).textTheme.headline4,
                                    ),
                                  ),
                                  RoundedBox(
                                      warna: Colors.transparent,
                                      h: 0.20,
                                      w: 1,
                                      roundAll: true,
                                      child: LeadStream(
                                        session: widget.session,
                                        client: widget.client,
                                        direction: Axis.horizontal,
                                        limit: 100,
                                        height: 0.15,
                                        width: 0.6,
                                      )),
                                  const SpacingH(h: 0.05),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      // "Recent Opportunity",
                                      '70% chance',
                                      style:
                                          Theme.of(context).textTheme.headline4,
                                    ),
                                  ),
                                  RoundedBox(
                                    warna: Colors.transparent,
                                    h: 0.20,
                                    w: 1,
                                    roundAll: true,
                                    child: OpportunityStream(
                                      client: widget.client,
                                      session: widget.session,
                                      direction: Axis.horizontal,
                                      height: 0.15,
                                      width: 0.6,
                                      limit: 5,
                                      filter: 3,
                                    ),
                                  ),
                                  // const Neumorphic()
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
