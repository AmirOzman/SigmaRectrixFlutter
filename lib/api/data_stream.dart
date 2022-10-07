import 'package:flutter/material.dart';
import 'package:sigma_crm/widget/widget.dart';

class DbStream extends StatefulWidget {
  final OdooClient client;
  final Axis direction;
  final int limit;
  final List? fields;
  final String tableName;
  final List? filter;
  final String title;
  final String? subtitle;

  const DbStream(
      {Key? key,
      required this.client,
      required this.direction,
      required this.limit,
      required this.tableName,
      required this.fields,
      required this.filter,
      required this.title,
      required this.subtitle})
      : super(key: key);

  @override
  State<DbStream> createState() => _DbStreamState();
}

class _DbStreamState extends State<DbStream> {
  @override
  Widget build(BuildContext context) {
    Future<dynamic> fetchLead() {
      return widget.client.callKw({
        'model': widget.tableName,
        'method': 'search_read',
        'args': [],
        'kwargs': {
          'context': {'bin_size': true},
          'domain': [widget.filter],
          'fields': [widget.fields],
          'limit': widget.limit,
          // 'order':,
        },
      });
    }

    Widget buildListLeads(Map<String, dynamic> record) {
      var unique = record['name'] as String;

      unique = unique.replaceAll(RegExp(r'[^0-9]'), '');
      return ListTile(
        selectedTileColor: Colors.orange,
        title: Text(
          record[widget.fields![0]],
          // record[fields[0]],
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Column(
          children: [
            Text(
              record[widget.fields![1]].toString(),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              record[widget.fields![2]].toString(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
        trailing: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              child: const Text('Edit'),
              onPressed: () {},
            ),
            TextButton(
              child: const Text('Change Rating'),
              onPressed: () {},
            ),
            TextButton(
              child: const Text('Convert to Task'),
              onPressed: () {},
            ),
            // IconButton(
            //   icon: const Icon(Icons.edit),
            //   onPressed: () {},
          ],
        ),
      );
    }

    return FutureBuilder(
      future: fetchLead(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        // if (ConnectionState.waiting){}
        if (snapshot.hasData) {
          return CustomScrollView(
            slivers: [
              SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                final record = snapshot.data[index] as Map<String, dynamic>;
                return Card(
                    clipBehavior: Clip.antiAlias,
                    child: InkWell(
                      child: RoundedBox(
                        roundAll: true,
                        warna: Colors.transparent,
                        h: 0.15,
                        w: 1,
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
                                              children: const [
                                                Text('Email :'),
                                                SpacingH(
                                                  h: 0.01,
                                                ),
                                                Text('Date Created :')
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
                                                Text(record['email_from']),
                                                const SpacingH(
                                                  h: 0.01,
                                                ),
                                                Text(record['create_date']),
                                              ],
                                            ),
                                          ],
                                        ),
                                        const SpacingAll(
                                          h: 0.05,
                                          w: 1,
                                        ),
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              ButtonText(
                                                nama: "Mark as Lost",
                                                lebar: 0.4,
                                                onPressed: () {},
                                                warna: Colors.red,
                                              ),
                                              ButtonText(
                                                  nama:
                                                      "Convert to Opportunity",
                                                  lebar: 0.4,
                                                  warna: Colors.green,
                                                  onPressed: () {}),
                                            ]),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });
                      },
                    ));
              }, childCount: snapshot.data.length))
            ],
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
