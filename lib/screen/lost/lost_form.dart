import 'package:flutter/material.dart';
import 'package:sigma_crm/widget/widget.dart';
import 'package:sigma_crm/api/api.dart';

class LostForm extends StatelessWidget {
  final OdooClient client;
  final OdooSession session;
  final String clientName;
  final String desc;
  const LostForm({
    Key? key,
    required this.client,
    required this.session,
    required this.clientName,
    required this.desc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBarCustom(
            client: client,
            session: session,
            tajuk: Text('${clientName}'),
            float: true,
            log: false,
            find: false,
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              GestureDetector(
                onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
                child: SingleChildScrollView(
                  child: Stack(children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: screenSize.height * 0.025,
                        horizontal: screenSize.width * 0.1,
                      ),
                      child: Column(children: [
                        Form(
                          child: Column(children: [
                            Text('Description'),
                            SpacingVertical(10),
                            Container(
                              width: double.infinity,
                              height: 80,
                              child: SingleChildScrollView(),
                            ),
                            LostReason(client, session),
                          ]),
                        )
                      ]),
                    )
                  ]),
                ),
              )
            ]),
          )
        ],
      ),
    );
  }
}
