import 'package:flutter/material.dart';
import 'package:sigma_crm/widget/widget.dart';

class AboutUs extends StatelessWidget {
  final OdooClient client;
  final OdooSession session;
  const AboutUs({
    Key? key,
    required this.client,
    required this.session,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBarCustom(
            client: client,
            session: session,
            tajuk: const Text('About Us'),
            float: true,
            log: true,
            find: false,
          ),
          SliverFillRemaining(
            child: Center(
              child: Column(),
            ),
          ),
        ],
      ),
    );
  }
}
