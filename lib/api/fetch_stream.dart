import 'package:flutter/material.dart';
import 'package:sigma_crm/widget/widget.dart';

class FutureFetch extends StatelessWidget {
  final OdooClient client;
  final Axis direction;
  final String tableName;
  final String operations;
  final List fields;
  final int limit;
  final List? filter;

  const FutureFetch(
      {Key? key,
      required this.client,
      required this.direction,
      required this.tableName,
      required this.operations,
      required this.fields,
      required this.limit,
      this.filter})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<dynamic> fetchStream() {
      return client.callKw({
        'model': tableName,
        'method': operations,
        'args': [],
        'kwargs': {
          'context': {'bin_size': true},
          'domain': [filter],
          'fields': [fields],
        },
        'limit': limit,
      });
    }

    Widget buildListStream(Map<String, dynamic> record) {
      var unique = record['name'] as String;

      unique = unique.replaceAll(RegExp(r'[^0-9]'), '');
      return ListTile(
        title: Text(
          record['name'],
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.headline6,
        ),
      );
    }

    return FutureBuilder(
      future: fetchStream(),
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
                      h: 0.15,
                      w: 1,
                      child: Column(
                        children: [buildListStream(record)],
                      ),
                    ),
                    onTap: () {
                      if (tableName == 'crm.lead') {
                        bottomSheetLead(context, record);
                      } else if (tableName == 'crm.lead.opportunity') {
                        bottomSheetOpportunity(context, record);
                      }
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
          return const CircularProgressIndicator.adaptive();
        }
      },
    );
  }

  Future<dynamic> bottomSheetLead(
      BuildContext context, Map<String, dynamic> record) {
    return showModalBottomSheet(
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        //this is the title
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          ButtonText(
                            nama: "Mark as Lost",
                            lebar: 0.4,
                            onPressed: () {},
                            warna: Colors.red,
                          ),
                          ButtonText(
                              nama: "Convert to Opportunity",
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
  }

//TODO adjust display for bottomsheet opportunity
  Future<dynamic> bottomSheetOpportunity(
      BuildContext context, Map<String, dynamic> record) {
    return showModalBottomSheet(
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        //this is the title
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          ButtonText(
                            nama: "Mark as Lost",
                            lebar: 0.4,
                            onPressed: () {},
                            warna: Colors.red,
                          ),
                          ButtonText(
                              nama: "Convert to Opportunity",
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
  }
}
