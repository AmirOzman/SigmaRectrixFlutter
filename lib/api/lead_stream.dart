// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:sigma_crm/widget/widget.dart';
import 'package:sigma_crm/screen/screen.dart';
import 'package:intl/intl.dart';

class LeadStream extends StatefulWidget {
  final OdooClient client;
  final OdooSession session;
  final Axis direction;
  final int limit;
  final double height;
  final double width;

  const LeadStream({
    Key? key,
    required this.client,
    required this.session,
    required this.direction,
    required this.limit,
    required this.height,
    required this.width,
  }) : super(key: key);

  @override
  State<LeadStream> createState() => _LeadStreamState();
}

class _LeadStreamState extends State<LeadStream> {
  @override
  Widget build(BuildContext context) {
    // ignore: todo
    //TODO implement try catch error for checking constant connection from odoo package
    Future<dynamic> fetchLeads() async {
      return widget.client.callKw({
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
          'limit': widget.limit,
        },
      });
    }

    Widget partnerName(Map<String, dynamic> record) {
      var partnerName = record['partner_name'] as String;

      if (partnerName.isEmpty) {
        return const Text('null');
      } else {
        return Text(partnerName);
      }
    }

    Widget partnerID(Map<String, dynamic> record) {
      if (record['partner_id'] == false) {
        return const Text('null');
      } else {
        return Text(record['partner_id']);
      }
      // var partnerId = record['partner_id'] as String;
      // record['partner_id'] == false ? return const Text(
      //                                                     'no description')
      //                                                 : returnText(
      //                                                     record['description']
      //                                                         .toString(),

      // if (partnerId.isEmpty) {
      //   return const Text('null');
      // } else {
      //   return Text(partnerId);
      // }
    }

    Widget buildCardLeads(Map<String, dynamic> record) {
      return Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [],
        ),
      );
    }

    Widget buildListLeads(Map<String, dynamic> record) {
      var unique = record['name'] as String;

      unique = unique.replaceAll(RegExp(r'[^0-9]'), '');
      // ignore: unused_local_variable
      final customerID = record['partner_id'];
      return ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(
              '${widget.client.baseURL}/web/image?model=res.partner&id=${record['partner_id']}&field=image_medium',
              headers: {"X-Openerp-Session-Id": widget.client.sessionId!.id}),
        ),
        // tileColor:
        //     record['priority'] == true ? Colors.amberAccent : Colors.blueGrey,
        title: Center(
          child: Text(
            record['name'],
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        subtitle: Center(
            child: record['partner_name'] == false
                ? const Text('unnamed partner')
                : Text(record['partner_name'])
            // Text(
            //   record['partner_name'],
            //   maxLines: 2,
            //   overflow: TextOverflow.ellipsis,
            // ),
            ),
        selectedTileColor: Colors.orange,
      );
    }

    return FutureBuilder(
      future: fetchLeads(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            shrinkWrap: false,
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
                                                                      widget
                                                                          .client,
                                                                      widget
                                                                          .session,
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
                                              ButtonIcon(
                                                  nama:
                                                      'Convert to Opportunity',
                                                  onPressed: () {
                                                    widget.client.callKw(
                                                      {
                                                        'model': 'crm.lead',
                                                        'method': 'write',
                                                        'args': [
                                                          record['id'],
                                                          {
                                                            'type':
                                                                'opportunity',
                                                          },
                                                        ],
                                                        'kwargs': {},
                                                      },
                                                    );
                                                    Navigator.of(context).pop();
                                                    Future.delayed(
                                                        const Duration(
                                                            seconds: 3), () {
                                                      Navigator
                                                          .pushAndRemoveUntil(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          ScreenView(
                                                                            widget.client,
                                                                            widget.session,
                                                                          )),
                                                              (route) => false);
                                                    });
                                                    setState(() {});

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
                                          // Row(
                                          //   mainAxisAlignment:
                                          //       MainAxisAlignment.spaceAround,
                                          //   crossAxisAlignment:
                                          //       CrossAxisAlignment.end,
                                          //   children: [
                                          //     ButtonText(
                                          //       nama: "Schedule an activity",
                                          //       lebar: 0.3,
                                          //       warna: Colors.black,
                                          //       onPressed: () {
                                          //         String customer =
                                          //             record['partner_name'];
                                          //         int customerID =
                                          //             record['partner_id'];
                                          //         Navigator.push(
                                          //           context,
                                          //           MaterialPageRoute(
                                          //             builder: (context) =>
                                          //                 //     ActivityFuture(
                                          //                 //   client,
                                          //                 //   session,
                                          //                 // ),
                                          //                 ActivityWCustomer(
                                          //               widget.client,
                                          //               widget.session,
                                          //               customer: customer,
                                          //               customerID: customerID,
                                          //             ),
                                          //           ),
                                          //         );
                                          //       },
                                          //     ),
                                          //     ButtonIcon(
                                          //       nama: 'Previous Meetings',
                                          //       onPressed: () {
                                          //         Navigator.push(
                                          //           context,
                                          //           MaterialPageRoute(
                                          //             builder: (context) =>
                                          //                 ActivityPast(
                                          //               widget.client,
                                          //               widget.session,
                                          //               customerName:
                                          //                   partnerName(record),
                                          //               customerID:
                                          //                   partnerID(record),
                                          //             ),
                                          //           ),
                                          //         );
                                          //       },
                                          //       icon: const Icon(
                                          //           Icons.people_outline),
                                          //     ),
                                          //     // ButtonText(
                                          //     //     nama: 'Previous Meetings',
                                          //     //     lebar: 0.3,
                                          //     //     onPressed: () {
                                          //     //       // Widget customerID =
                                          //     //       //     partnerID(record);

                                          //     //       //partnerID(record);
                                          //     //     })
                                          //   ],
                                          // ),
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
