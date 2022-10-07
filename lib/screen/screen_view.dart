import 'package:flutter/material.dart';
import 'package:sigma_crm/screen/screen.dart';
import 'package:sigma_crm/widget/widget.dart';

class ScreenView extends StatefulWidget {
  final OdooClient client;
  final OdooSession session;
  // final String baseURL;

  const ScreenView(
    this.client,
    this.session, {
    Key? key,
    // required this.baseURL,
  }) : super(key: key);

  @override
  State<ScreenView> createState() => _ScreenViewState();
}

class _ScreenViewState extends State<ScreenView> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 4,
      child: Scaffold(
        bottomNavigationBar: const BottomNav(),
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            HomeScreen(
              widget.client,
              widget.session,
              // baseURL: widget.baseURL,
            ),
            SalesTable(
              widget.client,
              widget.session,
            ),
            OpportunityView(
              widget.client,
              widget.session,
            ),
            ActivityView(
              widget.client,
              widget.session,
            ),
            
                     
          ],
        ),
      ),
    );
  }
}
