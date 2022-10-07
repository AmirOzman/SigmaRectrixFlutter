import 'package:flutter/material.dart';
import 'package:sigma_crm/widget/widget.dart';

class ActivityWCustomer extends StatefulWidget {
  final OdooClient client;
  final OdooSession session;
  final String customer;
  final int customerID;

  const ActivityWCustomer(
    this.client,
    this.session, {
    Key? key,
    required this.customer,
    required this.customerID,
  }) : super(key: key);

  @override
  State<ActivityWCustomer> createState() => _ActivityWCustomerState();
}

class _ActivityWCustomerState extends State<ActivityWCustomer> {
  //dropDown employee attendee
  List employeeNameList = [];
  List employeeParentList = [];
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchEmployee();
    });
    // TODO: implement initState
    super.initState();
  }

  Future fetchEmployee() async {}

  //dropDown employee attendee
  //TODO
  @override
  Widget build(BuildContext context) {
    final List attendees = [];
    //input
    final employee = TextEditingController();
    final title = TextEditingController();
    final description = TextEditingController();
    final location = TextEditingController();
    final bool allday;
    //input
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBarCustom(
            client: widget.client,
            session: widget.session,
            tajuk: const Text('Schedule an Activity'),
            float: true,
            log: true,
            find: false,
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
                            RoundedBox(
                              h: 0.10,
                              w: 1,
                              roundAll: true,
                              warna: Colors.cyan,
                              child: Column(
                                //TODO maybe use LayoutBuilder
                                children: [
                                  Text(widget.customer),
                                ],
                              ),
                            ),
                            TextForm(controller: employee, label: 'Associates'),
                            TextForm(
                                controller: title, label: 'Title of Meeting'),
                            TextForm(
                                controller: description, label: 'Description'),
                            TextForm(controller: location, label: 'Location'),
                            ButtonText(
                              nama: 'submit',
                              lebar: 0.4,
                              onPressed: () {
                                //customerID
                                //partner
                                //attendee
                                //userID
                                widget.client.callKw(
                                  {
                                    'model': 'calendar.event',
                                    'method': 'create',
                                    'args': [
                                      {
                                        'name': title.text,
                                        'description': description.text,
                                        'location': location.text,
                                        //state
                                        //start
                                        //stop
                                        //allday
                                        //start_datetime
                                        //stop_datetime
                                        //oe_update_date
                                      }
                                    ],
                                    'kwargs': {},
                                  },
                                );
                                //snackbar
                              },
                            )
                          ],
                        ),
                      ),
                    ],
                  ))
            ]),
          ),
        ],
      ),
    );
  }
}
