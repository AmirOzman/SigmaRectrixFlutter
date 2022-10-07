// import 'package:flutter/material.dart';
// import 'package:odoo_rpc/odoo_rpc.dart';

// class UserImage extends StatelessWidget {
//   final OdooClient client;
//   final OdooSession session;

//   const UserImage(this.client, this.session, {Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final ImageProvider gambar;
//     // final uid = session.userId;

//     try {
//       final uid = session.userId;
//       var res = await client.callKw({
//         'model':'res.users',
//         'method':'search_read',
//         'args':[],
//         'kwargs':{
//           'context':{'bin_size':true},
//           'domain':[
//             ['id','=',uid],
//             ],
//             'fields': 
//             ['id','name','__last_update',image_field],},},);
//     }

//     // Future<dynamic> getImage() {
//     //   var res = client.callKw(
//     //     {
//     //       'model': 'res_users',
//     //       'method': 'search_read',
//     //       'args': [],
//     //       'kwargs': {
//     //         'context': {'bin_size': true},
//     //         'domain': [
//     //           ['id', '=', uid]
//     //         ],
//     //         'fields': ['id', 'name', '__last_update'],
//     //       }
//     //     },
//     //   );
//     //   print('\nUser info: \n' + res.toString());
//     // }

//     // Widget buildImage(Map<String, dynamic> image) {
//     //   Image gambar = image['image'];

//     //   return SizedBox(
//     //     height: 150,
//     //     width: 150,
//     //     child: Image.asset(gambar),
//     //   );
//     // }

//     // return FutureBuilder(
//     //   future: getImage(),
//     //   builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
//     //     if (snapshot.hasData) {
//     //       return buildImage(gambar);
//     //     } else {}
//     //   },
//     // );
//   }
// }
