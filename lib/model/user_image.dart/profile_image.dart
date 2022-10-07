// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:odoo_rpc/odoo_rpc.dart';

// class ProfileImage extends StatelessWidget {
//   final OdooClient client;
//   final OdooSession session;
//   const ProfileImage({
//     Key? key,
//     required this.client,
//     required this.session,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final uid = session.userId;
//     final imageField =
//         session.serverVersionInt >= 13 ? 'image_128' : 'image_small';
//     Future<dynamic> fetchImage() {
//       return client.callKw({
//         'model': 'res_users',
//         'method': 'search_read',
//         'args': [],
//         'kwargs': {
//           'context': {'bin_size': true},
//           'domain': ['id', '=', uid],
//           'fields': [
//             'id',
//             'name',
//             '__last_update',
//             // image_field
//             imageField
//           ],
//         }
//       });
//     }

//     buildImage(Map<String, dynamic> record) {
//       final String userAvatar =
//           '$client/web/image?model=res.user&field=$imageField&id=$uid';
//       return userAvatar;
//     }

//     return FutureBuilder(
//       future: fetchImage(),
//       builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
//         if (snapshot.hasData) {
//           return ListView.builder(
//             shrinkWrap: false,
//             itemCount: snapshot.data.length,
//             itemBuilder: (context, index) {
//               final record = snapshot.data[index] as Map<String, dynamic>;
//               return Image.network(
//                 buildImage(record),
//               );
//             },
//           );
//         } else {
//           if (snapshot.hasError) {
//             return Column(
//               children: const [
//                 // SpacingH(h: 0.15),
//                 Center(
//                   child: Text('Unable to fetch image'),
//                 )
//               ],
//             );
//           }
//           return const Center(child: CircularProgressIndicator.adaptive());
//         }
//       },
//     );
//   }
// }
