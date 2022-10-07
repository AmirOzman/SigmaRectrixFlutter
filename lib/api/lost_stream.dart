import 'package:flutter/material.dart';
import 'package:sigma_crm/widget/widget.dart';

class LostStream extends StatelessWidget {
  final OdooClient client;
  final Axis direction;
  final int limit;
  final double height;
  final double width;
  const LostStream(
      {Key? key,
      required this.client,
      required this.direction,
      required this.limit,
      required this.height,
      required this.width})
      : super(key: key);

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
              // ['type', '=', 'opportunity'],
              ['stage_id', '=', 9],
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
            'limit': limit,
          }
        },
      );
    }
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
                      builder: (BuildContext context) {
                        return SingleChildScrollView(
                            child: RoundedBox(
                                h: 0.4,
                                w: 1,
                                roundAll: false,
                                warna: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Column(children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: const [
                                            Text('Email :'),
                                            SpacingH(h: 0.01),
                                            Text('Date Created : '),
                                            SpacingH(h: 0.01),
                                            Text('Lost Reason'),
                                            SpacingH(h: 0.01),
                                            Text('Description : ')
                                          ],
                                        ),
                                        const SpacingW(w: 0.01),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            record['email_from'] == false
                                                ? const Text('no email')
                                                : Text(
                                                    record['email'].toString()),
                                            const SpacingH(h: 0.01),
                                            record['create_date'] == false
                                                ? const Text('unrecorded date')
                                                : Text(record['create_date']
                                                    .toString()),
                                            const SpacingH(h: 0.01),
                                            record['lost_reason'] == false
                                                ? const Text('No reason')
                                                : Text(record['lost_reason']
                                                    .toString()),
                                            const SpacingH(h: 0.01),
                                            //FIXME repair overflow description
                                            SingleChildScrollView(
                                              child: record['description'] ==
                                                      false
                                                  ? const Text('No description')
                                                  : Text(record['description']
                                                      .toString()),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    const SpacingAll(h: 0.05, w: 1),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          ButtonIcon(
                                            nama: 'Convert to Opportunity',
                                            icon: const Icon(
                                                Icons.star_border_rounded),
                                            warna: Colors.green,
                                            onPressed: () {
                                              client.callKw({
                                                'model': 'crm.lead',
                                                'method': 'write',
                                                'args': [
                                                  record['id'],
                                                  {
                                                    'stage_id': 0,
                                                  },
                                                ]
                                              });
                                            },
                                          ),
                                        ]),
                                  ]),
                                )));
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
