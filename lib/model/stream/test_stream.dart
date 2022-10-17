// ignore_for_file: unused_local_variable, unused_catch_clause

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sigma_crm/screen/screen.dart';
import 'package:sigma_crm/widget/widget.dart';

class TestStream extends StatelessWidget {
  final OdooClient client;
  final OdooSession session;
  final Axis direction;
  final double height;
  final double width;
  TestStream(
    this.client,
    this.session, {
    Key? key,
    required this.direction,
    required this.height,
    required this.width,
  }) : super(key: key);

  Future<void> fetch() async {
    try {
      var res = await client.callKw({
        'model': 'crm.lead',
        'method': 'search_read',
        'args': [],
        'kwargs': {
          'context': {'bin_size': true},
          'domain': [
            ['type', '=', 'lead'],
            // ['partner_id', '!=', null]
          ],
          'fields': [
            'id',
            'name',
            'email_from',
            'create_date',
            'partner_name',
            'partner_id',
            'description',
            // ignore: todo
            //TODO show priority
            'priority',
          ],
        },
      });
    } on Exception catch (e) {
      // ignore: todo
      // TODO
    }
  }

  Widget buildCards(Map<String, dynamic> record) {
    return Card(
      child: ListTile(
        title: Center(
          child: Text(record['name']),
        ),
        subtitle: Center(
          child: Text(record['partner_id']),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetch(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            shrinkWrap: false,
            scrollDirection: direction,
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              final record = snapshot.data[index] as Map<String, dynamic>;
              return Card(
                clipBehavior: Clip.antiAlias,
                child: InkWell(
                  child: RoundedBox(
                    roundAll: true,
                    warna: Colors.transparent,
                    h: height,
                    w: width,
                    child: Column(
                      children: [buildCards(record)],
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
                              h: 0.5,
                              w: 1,
                              roundAll: false,
                              warna: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            // crossAxisAlignment:
                                            //     CrossAxisAlignment.center,
                                            children: [
                                              //this is the title
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        'Client :',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headline5,
                                                      ),
                                                      // checkEmail(record),
                                                      record['partner_name'] ==
                                                                  null ||
                                                              false
                                                          ? const Text(
                                                              'unregistered')
                                                          : Text(
                                                              record['partner_name']
                                                                  .toString(),
                                                            ),
                                                    ],
                                                  ),
                                                  SpacingPixel(h: 10),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        'Email :',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headline5,
                                                      ),
                                                      // checkEmail(record),
                                                      record['email_from'] ==
                                                                  null ||
                                                              false
                                                          ? const Text(
                                                              'no email')
                                                          : Text(
                                                              record['email']
                                                                  .toString(),
                                                            ),
                                                    ],
                                                  ),
                                                  SpacingPixel(h: 10),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        'Date Created :',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headline5,
                                                      ),
                                                      record['create_date'] ==
                                                              false
                                                          ? const Text(
                                                              'unknown date')
                                                          : Text(
                                                              DateFormat.yMd()
                                                                  .format(
                                                                DateTime.parse(
                                                                  record[
                                                                      'create_date'],
                                                                ),
                                                              ),
                                                            ),
                                                      // ignore: fixme
                                                      // FIXME testing print date
                                                      // Text(DateTime.parse(
                                                      //         record['create_date'])
                                                      //     .toString()),
                                                    ],
                                                  ),
                                                  const SpacingH(
                                                    h: 0.01,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Text(
                                            'Description :',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline4,
                                            textAlign: TextAlign.left,
                                          ),
                                          const SpacingH(
                                            h: 0.01,
                                          ),
                                          SingleChildScrollView(
                                            child:
                                                record['description'] == false
                                                    ? Text(
                                                        'no description',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyText1,
                                                      )
                                                    : Text(
                                                        record['description']
                                                            .toString(),
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyText1,
                                                        textAlign:
                                                            TextAlign.justify,
                                                      ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              ButtonIcon(
                                                  nama: 'Edit',
                                                  icon: const Icon(
                                                      Icons.edit_note_rounded),
                                                  warna: Colors.black,
                                                  onPressed: () {
                                                    print(record['description']
                                                            .toString() +
                                                        record['name']
                                                            .toString() +
                                                        record['partner_name']
                                                            .toString() +
                                                        record['priority']
                                                            .toString());
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    LeadForm(
                                                                      client,
                                                                      session,
                                                                      desc: record[
                                                                          'description'],
                                                                      leadname:
                                                                          record[
                                                                              'name'],
                                                                      clientName:
                                                                          record[
                                                                              'partner_name'],
                                                                      rate: double
                                                                          .parse(
                                                                              record['priority']),
                                                                    )));
                                                  }),
                                              // ignore: todo
                                              //TODO convert to opportunity button
                                              ButtonIcon(
                                                  nama:
                                                      'Convert to Opportunity',
                                                  onPressed: () async {
                                                    await client.callKw({
                                                      'model': 'res.partner',
                                                      'method': 'write',
                                                      'args': [
                                                        record['id'],
                                                        {
                                                          'type': 'opportunity',
                                                        },
                                                      ],
                                                      'kwargs': {},
                                                    });
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      const SnackBar(
                                                        behavior:
                                                            SnackBarBehavior
                                                                .floating,
                                                        content: Text(
                                                            'converted to Opportunity'),
                                                      ),
                                                    );
                                                  },
                                                  icon: const Icon(
                                                      Icons.move_up_rounded)),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              ButtonText(
                                                nama: "Schedule an activity",
                                                lebar: 0.3,
                                                warna: Colors.black,
                                                onPressed: () {
                                                  String customer =
                                                      record['partner_name'];
                                                  int customerID =
                                                      record['partner_id'];
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          //     ActivityFuture(
                                                          //   client,
                                                          //   session,
                                                          // ),
                                                          ActivityWCustomer(
                                                        client,
                                                        session,
                                                        customer: customer,
                                                        customerID: customerID,
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                              // ignore: todo
                                              //TODO Previous Meeting button
                                              // ButtonText(
                                              //     nama: 'Previous Meetings',
                                              //     lebar: 0.3,
                                              //     onPressed: () {
                                              //       // Widget customerID =
                                              //       //     partnerID(record);

                                              //       //partnerID(record);
                                              //     })
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                  },
                ),
              );
            },
          );
        } else {
          if (snapshot.hasError) {
            return Column(
              children: const [
                SpacingH(h: 0.15),
                Center(
                  child: Text('Unable to fetch data'),
                )
              ],
            );
          }
          return const Center(child: CircularProgressIndicator.adaptive());
        }
      },
    );
  }
}
