// ignore_for_file: unused_import, must_call_super, unused_element, unused_local_variable

import 'package:flutter/material.dart';
import 'package:sigma_crm/config/theme/theme.dart';
import 'package:sigma_crm/model/stream/activity/activity_event_participant.dart';
import 'package:sigma_crm/screen/activity/activity.dart';
import 'package:sigma_crm/widget/widget.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class ActivityStream extends StatefulWidget {
  final OdooClient client;
  final OdooSession session;
  final Axis direction;
  final int limit;
  final double height;
  final double width;
  final String? partnerName;
  final bool filterPartner;
  final bool past;

  const ActivityStream({
    Key? key,
    required this.client,
    required this.session,
    required this.direction,
    required this.limit,
    required this.height,
    required this.width,
    this.partnerName,
    this.filterPartner = false,
    this.past = false,
  }) : super(key: key);

  @override
  State<ActivityStream> createState() => _ActivityStreamState();
}

class _ActivityStreamState extends State<ActivityStream>
    with SingleTickerProviderStateMixin {
  late AnimationController calendarController;
  @override
  void initState() {
    super.initState();

    calendarController =
        AnimationController(duration: Duration(seconds: 3), vsync: this);

    calendarController.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        // Navigator.pop(context);
      }
      ;
    });
  }

  @override
  void dispose() {
    calendarController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future<dynamic> fetchActivity() async {
      String now = DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now());

      return widget.client.callKw({
        'model': 'calendar.event',
        'method': 'search_read',
        'args': [],
        'kwargs': {
          'context': {'bin_size': true},
          'domain': [
            ['res_model', '=', 'crm.lead'],
            widget.past ? ['start', '<=', now] : ['start', '>', now]
          ],
          'fields': [
            'name',
            'allday',
            'state', // whether it is draft or plan on course
            'duration',
            'opportunity_id',
            'start',
            'end',
            'start_datetime',
            'end_datetime',
            'location',
            'description',
            'day',
            'partner_ids'
          ],
          'limit': widget.limit,
        },
      });
    }

    Widget buildListCards(Map<String, dynamic> record) {
      String dateString = record['start'];
      final startDate = DateTime.parse(dateString);
      return Card(
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                  // ignore: todo
                  //TODO check for images of partner
                  // ignore: todo
                  //TODO change {widget.session.partnerId}
                  '${widget.client.baseURL}/web/image?model=res.partner&id=${widget.session.partnerId}&field=image_medium',
                  headers: {
                    "X-Openerp-Session-Id": widget.client.sessionId!.id
                  },
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Column(children: [
                Center(
                    child: Text(
                  record['name'],
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.headline6,
                )),
                Center(
                  child: Column(
                    children: [
                      Text(
                        DateFormat.yMMMEd().format(startDate),
                      ),
                      record['description'] == false
                          ? const Text(
                              'No Description',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            )
                          : Text(
                              record['description'].toString(),
                            ),
                    ],
                  ),
                ),
                ButtonIcon(
                  nama: '',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: ((context) => ActivityEdit(
                              client: widget.client,
                              session: widget.session,
                              location: record['location'],
                              partnerName: '',
                              title: record['name'],
                            )),
                      ),
                    );
                  },
                  icon: const Icon(Icons.edit_calendar_rounded),
                ),
              ]),
            ),
          ],
        ),
      );
    }

    Widget buildListLeads(Map<String, dynamic> record) {
      // ignore: fixme
      //FIXME map for partner ids / attendees

      var unique = record['name'] as String;
      String dateString = record['start'];
      final startDate = DateTime.parse(dateString);
      DateTime mula = DateTime.parse(record['start']);

      unique = unique.replaceAll(RegExp(r'[^0-9]'), '');

      return ListTile(
        leading: Text(
          DateFormat.MEd().format(startDate),
          style: Theme.of(context).textTheme.headline5?.copyWith(),
        ),
        title: Center(
          child: Text(
            record['name'],
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
        subtitle: Center(
          child: Column(
            children: [
              Text(
                DateFormat.yMMMEd().format(startDate),
              ),
              record['description'] == false
                  ? const Text(
                      'No Description',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    )
                  : Text(
                      record['description'].toString(),
                    ),
            ],
          ),
        ),
        trailing: ButtonIcon(
            nama: '',
            onPressed: () {
              // ignore: todo
              //TODO editing feature
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: ((context) => ActivityEdit(
              //             client: widget.client, session: widget.session))));
            },
            icon: const Icon(Icons.edit_calendar_rounded)),
        selectedTileColor: Colors.orange,
      );
    }

    return FutureBuilder(
      future: fetchActivity(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            shrinkWrap: true,
            scrollDirection: widget.direction,
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              final record = snapshot.data[index] as Map<String, dynamic>;
              return Card(
                  clipBehavior: Clip.antiAlias,
                  child: InkWell(
                    child: RoundedBox(
                      roundAll: true,
                      warna: Colors.transparent,
                      h: widget.height,
                      w: widget.width,
                      child: Column(
                        children: [buildListLeads(record)],
                      ),
                    ),
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20),
                            ),
                          ),
                          builder: (BuildContext context) {
                            return SingleChildScrollView(
                              child: RoundedBox(
                                h: 0.4,
                                w: 1,
                                roundAll: false,
                                warna: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Column(
                                    children: [
                                      Expanded(
                                        flex: 4,
                                        child: SingleChildScrollView(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              //this is the title
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: const [
                                                  Text(
                                                    'Name : ',
                                                  ),
                                                  SpacingH(
                                                    h: 0.01,
                                                  ),
                                                  Text(
                                                    'Date Scheduled : ',
                                                  ),
                                                  SpacingH(
                                                    h: 0.01,
                                                  ),
                                                  Text(
                                                    'Date End : ',
                                                  ),
                                                  SpacingH(
                                                    h: 0.01,
                                                  ),
                                                  Text(
                                                    'Duration : ',
                                                  ),
                                                  SpacingH(
                                                    h: 0.01,
                                                  ),
                                                  Text(
                                                    'Location : ',
                                                  ),
                                                  SpacingH(
                                                    h: 0.01,
                                                  ),
                                                  Text(
                                                    'Status : ',
                                                  ),
                                                  SpacingH(
                                                    h: 0.01,
                                                  ),
                                                  Text(
                                                    'Description',
                                                  ),
                                                ],
                                              ),
                                              const SpacingW(w: 0.01),
                                              //this is the data
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    record['name'],
                                                  ),
                                                  const SpacingH(
                                                    h: 0.01,
                                                  ),
                                                  Text(
                                                    record['start'],
                                                  ),
                                                  const SpacingH(
                                                    h: 0.01,
                                                  ),
                                                  Text(
                                                    record['stop'].toString(),
                                                  ),
                                                  const SpacingH(
                                                    h: 0.01,
                                                  ),
                                                  Text(
                                                    record['duration']
                                                        .toString(),
                                                  ),
                                                  const SpacingH(
                                                    h: 0.01,
                                                  ),
                                                  Text(
                                                    record['location']
                                                        .toString(),
                                                  ),
                                                  const SpacingH(
                                                    h: 0.01,
                                                  ),

                                                  Text(
                                                    record['state'].toString(),
                                                  ),
                                                  const SpacingH(
                                                    h: 0.01,
                                                  ),
                                                  //res_id for partner name
                                                  Text(
                                                    record['description']
                                                        .toString(),
                                                  ),
                                                  Wrap(
                                                    direction: Axis.horizontal,
                                                    children: List.generate(
                                                        record['partner_ids']
                                                            .length, (index) {
                                                      // ignore: fixme
                                                      //FIXME display id only not number
                                                      return Text(
                                                        '${record['partner_ids'][index].toString()} ',
                                                      );
                                                      // return ActivityEventParticipant(
                                                      //     client: widget.client,
                                                      //     direction:
                                                      //         Axis.horizontal,
                                                      //     partnerId: record[
                                                      //         'partner_ids']);
                                                    }),
                                                  ),
                                                  // Text(
                                                  //   record['partner_ids']
                                                  //       .toString(),
                                                  //   style: Theme.of(context)
                                                  //       .textTheme
                                                  //       .headline1,
                                                  // ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              ButtonIcon(
                                                  icon: const Icon(Icons.edit),
                                                  nama: 'Edit',
                                                  onPressed: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder:
                                                                ((context) =>
                                                                    ActivityEdit(
                                                                      client: widget
                                                                          .client,
                                                                      session:
                                                                          widget
                                                                              .session,
                                                                      title: record[
                                                                          'name'],
                                                                      location:
                                                                          record[
                                                                              'location'],
                                                                      partnerName: record[
                                                                          // ignore: fixme
                                                                          'partnerName'], //FIXME takleh fetch partnerName
                                                                    ))));
                                                  }),
                                              ButtonIcon(
                                                nama: 'Cancel',
                                                icon: const Icon(
                                                    Icons.flag_circle_outlined),
                                                warna: Colors.red,
                                                onPressed: () {},
                                              ),
                                              ButtonIcon(
                                                nama: 'Reschedule',
                                                onPressed: () {},
                                                icon: const Icon(
                                                    Icons.move_up_rounded),
                                                warna: Colors.green,
                                              ),
                                            ]),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                    },
                  ));
            },
          );
          // ignore: todo
          //TODO repetitive hasData
        } else if (!snapshot.hasData) {
          return Card(
            child: Column(
              children: [
                Lottie.asset('assets/calendar.json',
                    controller: calendarController, onLoaded: (composition) {
                  calendarController.forward();
                }),
                Center(child: Text('No Data')),
              ],
            ),
          );
        }
        // else if (snapshot.connectionState != ConnectionState.done) {
        //   return const Center(child: CircularProgressIndicator.adaptive());
        // }
        else {
          if (snapshot.hasError) {
            return RoundedBox(
              h: 0.20,
              w: 1,
              warna: Colors.white,
              roundAll: true,
              child: Align(
                alignment: Alignment.center,
                child: Column(
                  children: const [
                    Icon(Icons.error_outline),
                    Text(
                      'Unable to fetch data',
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
            );
          }
          // ignore: todo
          //TODO swap places with connectionstate error or Waiting Connection
          return Card(
            child: Column(
              children: [
                Lottie.asset('assets/calendar.json',
                    controller: calendarController, onLoaded: (composition) {
                  calendarController.forward();
                }),
                Center(child: Text('No Data')),
              ],
            ),
          );
        }
      },
    );
  }
}
