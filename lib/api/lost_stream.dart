import 'package:flutter/material.dart';
import 'package:sigma_crm/widget/widget.dart';
//import 'package:sigma_crm/screen/screen.dart';
//import 'package:intl/intl.dart';

class LostStream extends StatelessWidget {
  final OdooClient client;
  final Axis direction;
  final int limit;
  final double height;
  final double width;
  const LostStream({
    Key? key,
    required this.client,
    required this.direction,
    required this.limit,
    required this.height,
    required this.width,
    required int filter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<dynamic> fetchLost() {
      return client.callKw(
        {
          'model': 'crm.lead',
          'method': 'search_read',
          'args': [],
          'kwargs': {
            'context': {'bin_size': true},
            'domain': [
              ['type', '=', 'opportunity'],
              //['stage_id', '=', filter],
              ['active', '=', false]
              // ['probability', '=', 0],
              // ['lost_reason', '!=', false]
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
              'lost_reason'
            ],
            //'limit': limit,
          }
        },
      );
    }
    // ignore: todo
    //TODO figure out how to pass partner name to other widget to use.

    Widget buildListLost(Map<String, dynamic> record) {
      var unique = record['name'] as String;
      unique = unique.replaceAll(RegExp(r'[^0-9]'), '');
      return ListTile(
        title: Center(
          child: Text(
            record['name'],
          ),
        ),
        subtitle: Center(
          child: record['partner_name'] == false
              ? const Text('unnamed')
              : Text(record['partner_name'].toString()),
        ),
      );
    }

    var screensize = MediaQuery.of(context).size;
    var screenwidth = screensize.width;
    return FutureBuilder(
      future: fetchLost(),
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
                      children: [buildListLost(record)],
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
                        return Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              Wrap(
                                spacing: 6.0,
                                runSpacing: 4.0,
                                direction: Axis.horizontal,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      RoundedBox(
                                        h: 0.2,
                                        w: 0.9,
                                        roundAll: true,
                                        child: Row(
                                          children: [
                                            Column(
                                              children: [
                                                Center(
                                                  child: Container(
                                                    width:
                                                        screenwidth * 0.8 / 2,
                                                    child: Text(
                                                      'Email: ',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline5,
                                                    ),
                                                  ),
                                                ),
                                                SpacingVertical(10),
                                                Center(
                                                  child: Container(
                                                    width:
                                                        screenwidth * 0.8 / 2,
                                                    child: Text(
                                                      'Data Created: ',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline5,
                                                    ),
                                                  ),
                                                ),
                                                SpacingVertical(10),
                                                Center(
                                                  child: Container(
                                                    width:
                                                        screenwidth * 0.8 / 2,
                                                    child: Text(
                                                      'Lost Reason: ',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline5,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                record['email_from'] == null
                                                    ? Text(
                                                        record['email']
                                                            .toString(),
                                                      )
                                                    : Text(
                                                        'no email',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headline5!
                                                            .copyWith(
                                                              fontStyle:
                                                                  FontStyle
                                                                      .italic,
                                                            ),
                                                      ),
                                                SpacingVertical(10),
                                                record['create_date'] == false
                                                    ? Text('unrecorded date',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headline5)
                                                    : Text(
                                                        record['create_date']
                                                            .toString(),
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headline5),
                                                SpacingVertical(10),
                                                record['lost_reason'] == false
                                                    ? Text('No reason',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headline5)
                                                    : Text(
                                                        record['lost_reason']
                                                            .toString(),
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headline5),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Text(
                                'Description: ',
                                style: Theme.of(context).textTheme.headline5,
                              ),
                              Expanded(
                                child: SingleChildScrollView(
                                  physics: AlwaysScrollableScrollPhysics(),
                                  child: record['description'] == false
                                      ? Container(
                                          child: Text(
                                            'No Description',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline5!
                                                .copyWith(
                                                    fontStyle:
                                                        FontStyle.italic),
                                          ),
                                        )
                                      : Text(
                                          record['description'].toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline5!
                                              .copyWith(
                                                fontStyle: FontStyle.italic,
                                              ),
                                        ),
                                ),
                              ),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    ButtonIcon(
                                      nama: 'Convert to Opportunity',
                                      icon:
                                          const Icon(Icons.star_border_rounded),
                                      warna: Colors.green,
                                      onPressed: () {
                                        client.callKw(
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
                                      },
                                    ),
                                  ]),
                            ],
                          ),
                        );
                      },
                    );
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
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }
      },
    );
  }
}
