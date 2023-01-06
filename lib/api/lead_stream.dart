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
  void dispose() {
    super.dispose();
  }

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
          //'limit': widget.limit,
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
      final customerID = record['partner_id'];
      final avatarURL;

      if (customerID != false) {
        avatarURL =
            '${widget.client.baseURL}/web/image?model=res.partner&id=${customerID[0]}&field=image_medium';
      } else
        (avatarURL = null);

      var unique = record['name'] as String;
      unique = unique.replaceAll(RegExp(r'[^0-9]'), '');
      // ignore: unused_local_variable

      return ListTile(
        leading: avatarURL != null
            ? CircleAvatar(
                onBackgroundImageError: null,
                backgroundImage: NetworkImage(
                  avatarURL,
                  headers: {
                    "X-Openerp-Session-Id": widget.client.sessionId!.id
                  },
                ),
              )
            : CircleAvatar(
                backgroundColor: Colors.black,
              ),

        // tileColor:
        //     record['priority'] == true ? Colors.amberAccent : Colors.blueGrey,
        title: Center(
          child: Text(
            record['name'],
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.headline5,
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
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Expanded(
                                          flex: 3,
                                          child: ButtonIcon(
                                            nama: 'Edit',
                                            icon: const Icon(
                                                Icons.edit_note_rounded),
                                            warna: Colors.black,
                                            onPressed: () {
                                              print(record['description']
                                                      .toString() +
                                                  record['name'].toString() +
                                                  record['partner_name']
                                                      .toString() +
                                                  record['priority']
                                                      .toString());
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          LeadForm(
                                                            widget.client,
                                                            widget.session,
                                                            id: record['id'],
                                                            desc: record[
                                                                        'description'] ==
                                                                    false
                                                                ? 'no description'
                                                                : record[
                                                                    'description'],
                                                            leadname:
                                                                record['name'],
                                                            clientName: record[
                                                                        'partner_name'] ==
                                                                    false
                                                                ? 'no partner name'
                                                                : record[
                                                                    'partner_name'],
                                                            rate: double.parse(
                                                                record[
                                                                    'priority']),
                                                          )));
                                            },
                                          ),
                                        ),
                                        Expanded(child: SpacingHorizontal(20)),
                                        Expanded(
                                          flex: 3,
                                          child: ButtonIcon(
                                            nama: 'Convert to Opportunity',
                                            icon: const Icon(
                                                Icons.move_up_rounded),
                                            warna: Colors.green,
                                            onPressed: () {
                                              widget.client.callKw(
                                                {
                                                  'model': 'crm.lead',
                                                  'method': 'write',
                                                  'args': [
                                                    record['id'],
                                                    {
                                                      'type': 'opportunity',
                                                    },
                                                  ],
                                                  'kwargs': {},
                                                },
                                              );
                                              Navigator.of(context).pop();

                                              Navigator.pushAndRemoveUntil(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          ScreenView(
                                                            widget.client,
                                                            widget.session,
                                                          )),
                                                  (route) => false);

                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  behavior:
                                                      SnackBarBehavior.floating,
                                                  content: Text(
                                                      'converted to Opportunity'),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Expanded(
                                          flex: 3,
                                          child: Center(
                                            child: ButtonIcon(
                                              nama: 'Activities',
                                              warna: Colors.blue,
                                              onPressed: () {
                                                final clientID = record['id'];

                                                final clientName = record[
                                                            'partner_name'] ==
                                                        false
                                                    ? 'Unnamed'
                                                    : record['partner_name'];
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        ClientView(
                                                      widget.client,
                                                      widget.session,
                                                      clientId: clientID,
                                                      clientName: clientName,
                                                    ),
                                                  ),
                                                );
                                              },
                                              icon: const Icon(
                                                  Icons.people_outline),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
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
