// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:sigma_crm/config/theme/theme.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      // elevation: ,
      child: TabBar(
          // unselectedLabelColor: Colors.white,
          // labelColor: COLOR_4,
          // indicator: BoxDecoration(
          //   color: Colors.white,
          //   borderRadius: BorderRadius.only(
          //     topLeft: Radius.circular(10),
          //     topRight: Radius.circular(10),
          //   ),
          // ),
          tabs: const [
            Tab(
              child: Center(
                child: Text(
                  'Home',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Tab(
              child: Text(
                'Lead',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ),
            Tab(
              child: Text(
                'Opportunity',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ),
            // Tab(
            //   child: Text(
            //     'Quotations',
            //     style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
            //   ),
            // ),
            Tab(
              child: Text(
                'Activity',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ),
          ]),
    );
  }
}
