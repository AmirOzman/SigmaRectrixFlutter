// import 'package:flutter/material.dart';
// import 'package:sigma_crm/screen/screen.dart';
// import 'package:sigma_crm/widget/widget.dart';

// const String 
// class AppRouter {
//   static Route onGenerateRoute(RouteSettings settings) {
//     print('Route: ${settings.name}');
//     switch (settings.name) {
//       case '/':
//       // return HomeScreen.route();
//       // case SplashScreen.routeName:
//       //   return SplashScreen.route();
//       // case CartScreen.routeName:
//       //   return CartScreen.route();
//       // case ProductScreen.routeName:
//       //   return ProductScreen.route(product: settings.arguments as Product);
//       // case CatalogScreen.routeName:
//       //   return CatalogScreen.route(category: settings.arguments as Category);
//       default:
//         return _errorRoute();
//     }
//   }

//   static Route _errorRoute() {
//     final OdooClient client;

//     return MaterialPageRoute(
//       settings: const RouteSettings(name: '/error'),
//       builder: (_) => Scaffold(
//         appBar: AppBarCustom(
//           client: widget.client,
//           session: widget.session,
//           tajuk: 'Error',
//           log: false,
//         ),
//         body: Center(
//           child: Column(
//             children: const [
//               Icon(
//                 Icons.cell_tower_rounded,
//                 size: 200.0,
//               ),
//               Text('Something went wrong!'),
//               Text('Please Check Your Internet Connection'),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// // }
// }
