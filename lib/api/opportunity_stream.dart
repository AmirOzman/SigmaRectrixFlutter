// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:sigma_crm/widget/widget.dart';
import 'package:sigma_crm/screen/screen.dart';

class OpportunityStream extends StatelessWidget {
  final OdooClient client;
  final OdooSession session;
  final Axis direction;
  final int limit;
  final double height;
  final double width;
  // bool? lost;
  final int filter;

  const OpportunityStream({
    Key? key,
    required this.client,
    required this.session,
    required this.direction,
    required this.limit,
    required this.height,
    required this.width,
    // this.lost,
    this.filter = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<dynamic> fetchOpportunity() {
      return client.callKw({
        'model': 'crm.lead',
        'method': 'search_read',
        'args': [],
        'kwargs': {
          'context': {'bin_size': true},
          'domain': [
            ['type', '=', 'opportunity'],
            //['stage_id', '=', filter],
          ],
          'fields': [
            'id',
            'name',
            'email_from',
            'create_date',
            'partner_name',
            'description',
            'type',
            'active',
            'probability',
            'stage_id',
            'lost_reason',
          ],
          //'limit': limit,
          //offset
        },
      });
    }

    Widget buildListLeads(Map<String, dynamic> record) {
      var unique = record['name'] as String;

      unique = unique.replaceAll(RegExp(r'[^0-9]'), '');
      return ListTile(
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
              ? const Text('unnamed')
              : Text(
                  record['partner_name'],
                ),
        ),
        selectedTileColor: Colors.orange,
      );
    }

    return FutureBuilder(
      future: fetchOpportunity(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            shrinkWrap: true,
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
                            return RoundedBox(
                              h: 0.6,
                              w: 1,
                              roundAll: false,
                              warna: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  children: [
                                    Row(
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
                                          children: [
                                            RoundedBox(
                                              h: 0.1,
                                              w: 0.8,
                                              roundAll: true,
                                              child: Row(
                                                children: [
                                                  RoundedBox(
                                                    h: 0.1,
                                                    w: 0.4,
                                                    roundAll: true,
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                          'Customer : ',
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .headline5,
                                                        ),
                                                        SpacingVertical(10),
                                                        Text(
                                                          'Email : ',
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .headline5,
                                                        ),
                                                        SpacingPixel(
                                                          h: 10,
                                                        ),
                                                        Text(
                                                          'Date Created : ',
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .headline5,
                                                        ),
                                                        SpacingVertical(10),
                                                        Text(
                                                          'Meeting Count',
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .headline5,
                                                        ),
                                                        SpacingPixel(
                                                          h: 10,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      record['partner_name'] ==
                                                              null
                                                          ? Text(
                                                              'Unregistered Customer',
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .headline5,
                                                            )
                                                          : Expanded(
                                                              child: Text(
                                                                  record[
                                                                      'partner_name'],
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .headline5,
                                                                  maxLines: 2,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .fade),
                                                            ),
                                                      SpacingVertical(10),
                                                      record['email_from'] ==
                                                              null
                                                          ? Text(
                                                              record['email']
                                                                  .toString(),
                                                            )
                                                          : Text('no email',
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .headline5!
                                                                  .copyWith(
                                                                    fontStyle:
                                                                        FontStyle
                                                                            .italic,
                                                                  )),

                                                      SpacingVertical(10),
                                                      record['create_date'] ==
                                                              false
                                                          ? Text(
                                                              'unrecorded date',
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .headline5)
                                                          : Text(
                                                              record['create_date']
                                                                  .toString(),
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .headline5),
                                                      SpacingVertical(10),
                                                      // ignore: todo
                                                      //TODO maybe put lost reason
                                                      record['meeting_count'] ==
                                                                  null ||
                                                              false
                                                          ? Text(
                                                              'no meeting conducted',
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .headline5
                                                              // TextStyle(
                                                              //   fontStyle:
                                                              //       FontStyle
                                                              //           .italic,
                                                              // )
                                                              )
                                                          : Text(
                                                              record['meeting_count']
                                                                  .toString(),
                                                            ),
                                                      // const SpacingPixel(
                                                      //   h: 10,
                                                      // ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        // const SpacingW(w: 0.01),
                                        //this is the data
                                      ],
                                    ),
                                    RoundedBox(
                                      h: 0.2,
                                      w: 0.8,
                                      roundAll: true,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Description : ',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline5,
                                          ),
                                          const SpacingPixel(
                                            h: 20,
                                          ),
                                          RoundedBox(
                                            h: 0.15,
                                            w: 0.8,
                                            roundAll: false,
                                            child: SingleChildScrollView(
                                              child: record['description'] ==
                                                      false
                                                  ? Text(
                                                      'No Description',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline5!
                                                          .copyWith(
                                                            fontStyle: FontStyle
                                                                .italic,
                                                          ),
                                                    )
                                                  : Text(
                                                      record['description']
                                                          .toString(),
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline5,
                                                    ),
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
                                            nama: 'Mark as Lost',
                                            icon: const Icon(
                                                Icons.flag_circle_outlined),
                                            warna: Colors.red,
                                            onPressed: () {
                                              // ignore: todo
                                              //TODO amik callkw edit stage_id ngan lost_reason
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      LostForm(
                                                    client: client,
                                                    session: session,
                                                    clientName:
                                                        record['partner_name'],
                                                    desc: record['desc'],
                                                  ),
                                                ),
                                              );

                                              // ignore: todo
                                              //TODO dialog untuk letak lost reason
                                            },
                                          ),
                                        ),
                                        Expanded(child: SpacingHorizontal(20)),
                                        Expanded(
                                          flex: 3,
                                          child: ButtonIcon(
                                            nama: 'Convert to Opportunity',
                                            icon: const Icon(
                                                Icons.star_border_rounded),
                                            warna: Colors.green,
                                            onPressed: () {
                                              // ignore: todo
                                              //TODO Convert to Opportunity
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
                                          child: ButtonIcon(
                                            nama: 'Activities',
                                            onPressed: () {
                                              final clientID = record['id'];

                                              final clientName =
                                                  record['partner_name'] ==
                                                          false
                                                      ? 'Unnamed'
                                                      : record['partner_name'];
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ClientView(
                                                    client,
                                                    session,
                                                    clientId: clientID,
                                                    clientName: clientName,
                                                  ),
                                                ),
                                              );
                                            },
                                            icon: const Icon(
                                                Icons.people_outlined),
                                          ),
                                        ),
                                        Expanded(child: SpacingHorizontal(20)),
                                        Expanded(
                                          flex: 3,
                                          child: ButtonIcon(
                                            nama: 'Edit',
                                            onPressed: () {
                                              final clientID = record['id'];
                                              final clientName =
                                                  record['partner_name'] ==
                                                          false
                                                      ? 'Unnamed'
                                                      : record['partner_name'];
                                              final description =
                                                  record['description'] == false
                                                      ? 'Unnamed'
                                                      : record['description'];
                                              // ignore: todo
                                              //TODO opportunity edit navigation
                                              // Navigator.push(
                                              //     context,
                                              //     MaterialPageRoute(
                                              //         builder: (context) =>
                                              //             OpportunityEdit(
                                              //                 client, session,
                                              //                 clientId: clientID,
                                              //                 clientName:
                                              //                     clientName,
                                              //                 description:
                                              //                     description)));
                                            },
                                            icon: const Icon(
                                                Icons.edit_note_outlined),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          });
                    },
                  ));
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
