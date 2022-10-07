import 'package:flutter/material.dart';
import 'package:sigma_crm/screen/activity/specific_client/client_pass.dart';
import 'package:sigma_crm/screen/screen.dart';
import 'package:flutter/widgets.dart';
import 'package:sigma_crm/widget/widget.dart';

class ClientView extends StatefulWidget {
  final OdooClient client;
  final OdooSession session;
  final int clientId;
  final String clientName;

  const ClientView(
    this.client,
    this.session, {
    Key? key,
    required this.clientId,
    required this.clientName,
  }) : super(key: key);

  @override
  State<ClientView> createState() => _ClientViewState();
}

class _ClientViewState extends State<ClientView> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: Scaffold(
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
            floatingActionButton: ButtonNewActivity(
              client: widget.client,
              session: widget.session,
              customerID: widget.clientId,
              customerName: widget.clientName,
            ),
            body: CustomScrollView(slivers: [
              SliverAppBarCustom(
                client: widget.client,
                session: widget.session,
                tajuk: Text(widget.clientName),
                float: false,
                log: true,
                find: false,
                large: true,
                bottom: const TabBar(tabs: [
                  Tab(
                    text: 'Future Activity',
                  ),
                  Tab(text: 'Past Activity'),
                ]),
              ),
              SliverFillRemaining(
                child: TabBarView(
                  children: [
                    ClientFuture(
                      widget.client,
                      widget.session,
                      customerID: widget.clientId,
                      customerName: widget.clientName,
                    ),
                    const ClientPass()
                  ],
                ),
              ),
            ])));
  }
}
