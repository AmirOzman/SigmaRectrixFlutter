import 'package:flutter/material.dart';
import 'package:sigma_crm/widget/widget.dart';
import 'package:sigma_crm/screen/screen.dart';

class QuotationView extends StatefulWidget {
  final OdooClient client;
  final OdooSession session;
  // final String userAvatar;
  const QuotationView(this.client, this.session,
      //  this.userAvatar,
      {Key? key})
      : super(key: key);

  @override
  State<QuotationView> createState() => _QuotationViewState();
}

class _QuotationViewState extends State<QuotationView> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => showExitPopup(context),
      child: Scaffold(
        drawer: const Drawer(),
        body: DefaultTabController(
            length: 1,
            child: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  child: TabBarView(
                    children: [
                      QuotationNew(
                        widget.client,
                        widget.session,
                      ),
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }
}
