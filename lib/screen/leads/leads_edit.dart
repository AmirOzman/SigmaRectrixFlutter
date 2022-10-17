import 'package:flutter/material.dart';
import 'package:sigma_crm/widget/widget.dart';

class LeadEdit extends StatefulWidget {
  final OdooClient client;
  final OdooSession session;
  const LeadEdit(this.client, this.session, {Key? key}) : super(key: key);

  @override
  State<LeadEdit> createState() => _LeadEditState();
}

class _LeadEditState extends State<LeadEdit> {
  final leadName = TextEditingController();
  final clientName = TextEditingController();
  final description = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: [
      SliverAppBarCustom(
        client: widget.client,
        session: widget.session,
        tajuk: const Text('Lost'),
        float: true,
        log: true,
        find: true,
      ),
      SliverList(
        delegate: SliverChildListDelegate([
          PaddingCustom(
            h: 0.01,
            w: 0.05,
            child: Column(
              children: [
                RoundedBox(
                    h: 0.8,
                    w: 1,
                    roundAll: true,
                    child: Column(
                      children: [
                        TextForm(controller: leadName, label: 'Lead Name'),
                        TextForm(
                            controller: clientName, label: 'Customer Name'),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            RichText(
                              text: TextSpan(
                                  text: "Create ",
                                  style: const TextStyle(color: Colors.black),
                                  children: [
                                    TextSpan(
                                        text: "new customer",
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            // ignore: fixme
                                            //FIXME
                                            // addCompanyBottom();
                                          },
                                        style: const TextStyle(
                                          color: Colors.blue,
                                        ),
                                        children: const [
                                          TextSpan(
                                              text: " profile",
                                              style: TextStyle(
                                                  color: Colors.black))
                                        ])
                                  ]),
                            ),
                          ],
                        ),
                        TextForm(
                            controller: description,
                            label: 'Description',
                            max: 10,
                            kb: TextInputType.multiline)
                      ],
                    )
                    // DbStream(
                    //   client: widget.client,
                    //   direction: Axis.vertical,
                    //   tableName: 'crm.lead',
                    //   fields: [],
                    // ),
                    ),
              ],
            ),
          )
        ]),
      )
    ]);
  }
}
