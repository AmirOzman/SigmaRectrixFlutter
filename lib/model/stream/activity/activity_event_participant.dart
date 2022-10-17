// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:sigma_crm/widget/widget.dart';
import 'package:intl/intl.dart';

class ActivityEventParticipant extends StatefulWidget {
  final OdooClient client;
  final Axis direction;
  final List? filter;
  final List? record;
  final int partnerId;
  // final int partner;

  const ActivityEventParticipant({
    Key? key,
    required this.client,
    required this.direction,

    // required this.partner,
    this.filter,
    this.record,
    required this.partnerId,
  }) : super(key: key);

  @override
  State<ActivityEventParticipant> createState() =>
      _ActivityEventParticipantState();
}

class _ActivityEventParticipantState extends State<ActivityEventParticipant> {
  @override
  Widget build(BuildContext context) {
    Future<dynamic> getActivity() {
      return widget.client.callKw({
        'model': 'res.partner',
        'method': 'search_read',
        'args': [],
        'kwargs': {
          'context': {'bin_size': true},
          'domain': [
            // 'id',
            // '=',
            // fetchPartner(),
            ['id', '=', widget.partnerId],
          ],
          'fields': [
            'id',
            'name',
          ],
        }
      });
    }

    Widget buildListActivity(Map<String, dynamic> record) {
      return Text(record['name'].toString());
    }

    return FutureBuilder(
        future: getActivity(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemBuilder: (context, index) {
                final record = snapshot.data[index] as Map<String, dynamic>;
                return Column(
                  children: [buildListActivity(record)],
                );
              },
            );
          } else {
            return Center(
              child: Text(''),
            );
          }
        });

//     return FutureBuilder(
//       future: getActivity(),
//       builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
//         if (snapshot.hasData) {
//           return ListView.builder(
//             shrinkWrap: false,
//             scrollDirection: Axis.horizontal,
//             itemCount: snapshot.data.length,
//             itemBuilder: (context, index) {
//               final partner = snapshot.data[index] as Map<String, dynamic>;
//               return Card(
//                   clipBehavior: Clip.antiAlias,
//                   child: InkWell(
//                     child: RoundedBox(
//                       roundAll: true,
//                       warna: Colors.transparent,
//                       h: 200,
//                       w: 400,
//                       child: Column(
//                         children: [buildListActivity(partner)],
//                       ),
//                     ),
//                     onTap: () {
//                       showModalBottomSheet(
//                           shape: const RoundedRectangleBorder(
//                             borderRadius: BorderRadius.vertical(
//                               top: Radius.circular(20),
//                             ),
//                           ),
//                           context: context,
//                           builder: (BuildContext context) {
//                             return SingleChildScrollView(
//                                 child: RoundedBox(
//                               h: 0.4,
//                               w: 1,
//                               roundAll: false,
//                               child: Padding(
//                                 padding: const EdgeInsets.all(20.0),
//                                 child: Column(
//                                   children: [
//                                     Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.start,
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.center,
//                                       children: const [],
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             ));
//                           });
//                     },
//                   ));
//             },
//           );
//         } else {
//           if (snapshot.hasError) {
//             return Column(children: const [
//               SpacingH(h: 0.15),
//               Center(
//                 child: Text('Unable to fetch data'),
//               )
//             ]);
//           }
//           return const Center(
//             child: CircularProgressIndicator.adaptive(),
//           );
//         }
//       },
//     );

//     // Future<dynamic> getPartner() {
//     //   return widget.client.callKw({
//     //     'model': 'calendar_event_res_partner_rel',
//     //     'method': 'search_read',
//     //     'args': [],
//     //     'kwargs': {
//     //       'context': {'bin_size': true},
//     //       'domain': [
//     //         ['re_partner_id', '=', widget.partner],
//     //       ]
//     //     }
//     //   });
//     // }

//     // Widget buildListLeads(Map<String, dynamic> record) {
//     //   var unique = record['name'] as String;
//     //   String dateString = record['start'];
//     //   final startDate = DateTime.parse(dateString);

//     //   unique = unique.replaceAll(RegExp(r'[^0-9]'), '');
//     //   return ListTile(
//     //     leading:
//     //         // CircleAvatar(
//     //         // child:
//     //         Text(
//     //       // DateFormat.yMMMEd().format(startDate),
//     //       DateFormat.yMd().format(startDate),
//     //     ),
//     //     // backgroundColor: Colors.purple[100],
//     //     // ),
//     //     title: Center(
//     //       child: Text(
//     //         record['calendar_event_id'].toString(),
//     //         maxLines: 2,
//     //         overflow: TextOverflow.ellipsis,
//     //         style: Theme.of(context).textTheme.headline6,
//     //       ),
//     //     ),
//     //     subtitle: Center(
//     //       child: Column(
//     //         children: [
//     //           Text(
//     //             DateFormat.yMMMEd().format(startDate),
//     //           ),
//     //           Text(
//     //             record['res_partner_id'].toString(),
//     //           ),
//     //         ],
//     //       ),
//     //     ),
//     //     selectedTileColor: Colors.orange,
//     //   );
//     // }
//   }
// }

// // Future<dynamic> fetchActivity() {

// // }
  }
}
