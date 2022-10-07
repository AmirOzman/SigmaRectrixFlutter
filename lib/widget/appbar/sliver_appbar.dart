import 'package:flutter/material.dart';
import 'package:sigma_crm/screen/screen.dart';
import 'package:sigma_crm/widget/widget.dart';
import 'package:sigma_crm/config/theme/theme.dart';

class SliverAppBarCustom extends StatelessWidget {
  final OdooClient client;
  final OdooSession session;
  final Widget tajuk;
  final bool float;
  final bool log; //for logout button
  final bool find; //for find button
  final PreferredSizeWidget? bottom;
  final bool large;

  const SliverAppBarCustom(
      {Key? key,
      required this.client,
      required this.session,
      required this.tajuk,
      required this.float,
      required this.log,
      required this.find,
      this.large = false,
      this.bottom})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: tajuk,
      centerTitle: true,
      expandedHeight: large ? 100 : 60,
      backgroundColor: Colors.transparent,
      floating: float,
      actionsIconTheme: IconThemeData(color: Colors.white),
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15)),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              COLOR_4, COLOR_5,
              // Color(0xFFFF6200),
              // Color(0xFFFD7F2C),
              // Color(0xFFFD9346),
              // Color(0xFFFDA766),
              // Color(0xFFFDB777),
            ],
          ),
        ),
      ),
      bottom: bottom,
      actions: [
        find
            ? IconButton(
                icon: const Icon(Icons.search_rounded),
                onPressed: () {
                  showSearch(
                      context: context, delegate: CustomSearchDelegate());
                },
              )
            : const Text(''),
        log
            ? IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () async {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LogOutScreen(client, session)),
                      (Route<dynamic> route) => false);
                  await client.destroySession();
                  client.close();
                },
              )
            : const Text(''),
      ],
    );
  }
}

// PreferredSize(
//         preferredSize: const Size.fromHeight(60),
//         child: Container(
//           margin: const EdgeInsets.all(10),
//           decoration: BoxDecoration(
//               border: Border.all(color: Colors.white),
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(6)),
//           child: Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(0),
//                 child: Container(
//                   padding: const EdgeInsets.only(left: 5),
//                   height: 45,
//                   child: InkWell(
//                     child: Row(
//                       children: const [Icon(Icons.search), Text('Search here')],
//                     ),
//                     onTap: () {},
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),