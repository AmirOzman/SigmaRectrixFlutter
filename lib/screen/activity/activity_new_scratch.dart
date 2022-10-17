// ignore_for_file: unused_import, unused_local_variable

import 'package:flutter/material.dart';
import 'package:sigma_crm/widget/widget.dart';
import 'package:sigma_crm/model/model.dart';
import 'package:intl/intl.dart';

class ActivityNew extends StatefulWidget {
  final OdooClient client;
  final OdooSession session;
  final int clientId;
  final String clientName;
  const ActivityNew(
    this.client,
    this.session, {
    Key? key,
    required this.clientId,
    required this.clientName,
  }) : super(key: key);

  @override
  State<ActivityNew> createState() => _ActivityNewState();
}

class _ActivityNewState extends State<ActivityNew> {
  final customerName = TextEditingController();
  final location = TextEditingController();
  final description = TextEditingController();
  final attendee = TextEditingController();
  final eventName = TextEditingController();

  @override
  void initState() {
    customerName.text = widget.clientName; //default text
    super.initState();
  }

  double rating = 0;
  ValueNotifier<bool> haveCompany = ValueNotifier(false);
  List companyNameList = [];
  List customerParentList = [];
  String now = DateFormat("E dd-MM-yyyy hh:mm:ss").format(DateTime.now());
  // ignore: todo
  //TODO this is casting
  // DateTime now = DateFormat("E dd-MM-yyyy hh:mm:ss").format(DateTime.now()) as DateTime;
  // ignore: todo
  //TODO this for displaying month name and day
  //String now = DateFormat("E dd-LLLL-yyyy hh:mm:ss").format(DateTime.now()); // display month name
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  DateTime initialDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    // String startTime = 'Select Start Time';
    final screenSize = MediaQuery.of(context).size;
    TimeOfDay? startTime = TimeOfDay.now();
    TimeOfDay? endTime = TimeOfDay.now();
    late int companyId;
    DateTime? startDate;

    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              FloatingActionButton.extended(
                backgroundColor: Colors.black,
                label: Row(
                  children: const [
                    Icon(Icons.schedule_rounded),
                    SpacingPixel(
                      w: 10,
                    ),
                    Text('Schedule Activity'),
                  ],
                ),
                heroTag: null,
                onPressed: () {
                  widget.client.callKw(
                    {
                      'model': 'calendar.event',
                      'method': 'create',
                      'args': [
                        {
                          'name': customerName.text,
                          'location': location.text,
                          'res_model': 'crm.lead',
                          'opportunity_id': widget.clientId,
                        }
                      ]
                    },
                  );
                  //for loop participant
                  widget.client.callKw({
                    'model': 'calendar.event.res.partner',
                    'method': 'create',
                    'args': [
                      {
                        'res_partner_id': '',
                      }, //add multiple res.partner.id
                    ],
                  });
                  ScaffoldMessenger.of(context)
                      .showMaterialBanner(MaterialBanner(
                    content: Text('Activity Created'),
                    actions: [],
                  ));
                  // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  //   content: Text('Activity Created'),
                  // ));
                },
              )
            ]),
        body: CustomScrollView(
          slivers: [
            SliverAppBarCustom(
              client: widget.client,
              session: widget.session,
              tajuk: const Text('New Activity'),
              float: true,
              log: true,
              find: true,
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Padding(
                    padding: EdgeInsets.only(
                      top: screenSize.height * 0.025,
                      left: screenSize.width * 0.1,
                      right: screenSize.width * 0.1,
                      bottom: screenSize.height * 0.025,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(children: [
                          Column(
                            children: [
                              TextForm(
                                controller: eventName,
                                label: 'Event Title',
                                max: null,
                                kb: TextInputType.multiline,
                              ),
                              SpacingVertical(20),
                              TextField(
                                controller: customerName,
                                readOnly: true,
                                maxLines: null,
                                decoration: const InputDecoration(
                                    labelText: 'Customer',
                                    border: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black))),
                              ),
                              SpacingVertical(20),
                              TextForm(
                                controller: location,
                                label: 'Location',
                                max: null,
                                kb: TextInputType.multiline,
                              ),
                              const SpacingPixel(h: 20),
                              TextForm(
                                  controller: description,
                                  label: 'Description',
                                  kb: TextInputType.multiline,
                                  max: 10),

                              const SpacingPixel(h: 20),
                              //TypeAhead
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ButtonIcon(
                                    // ignore: fixme
                                    //FIXME datepick not responsive does not dynamically change the display of date
                                    nama: startDate == initialDate &&
                                            startTime == TimeOfDay.now()
                                        ? 'Select Start Date and Time'
                                        : DateFormat('E\t dd MMM yyyy')
                                            .format(endDate)
                                            .toString(),
                                    icon: const Icon(
                                        Icons.calendar_today_outlined),
                                    warna: Colors.green,
                                    onPressed: () async {
                                      DateTime? dateStart =
                                          await showDatePicker(
                                              context: context,
                                              initialDate: initialDate,
                                              firstDate: DateTime(2020),
                                              lastDate: DateTime(2050),
                                              confirmText: 'SELECT DATE');
                                      // ignore: fixme
                                      //FIXME
                                      //         .then((value) {
                                      //   setState(() {
                                      //     dateStart = startDate;
                                      //   });
                                      // });
                                      if (dateStart == null) return;

                                      setState(() => startDate = dateStart);
                                    },
                                  ),
                                  ButtonIcon(
                                      // ignore: fixme
                                      //FIXME timepicker not working
                                      nama: startTime == TimeOfDay.now()
                                          ? 'Pick Start Time'
                                          : startTime.toString(),
                                      warna: Colors.green,
                                      onPressed: () async {
                                        TimeOfDay? timeStart =
                                            await showTimePicker(
                                                context: context,
                                                confirmText: 'SELECT TIME',
                                                initialTime: TimeOfDay.now());
                                        if (timeStart == null) return;
                                        setState(() {
                                          startTime = timeStart;
                                        });
                                      },
                                      icon:
                                          const Icon(Icons.access_time_rounded))
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ButtonIcon(
                                    nama: endDate == initialDate &&
                                            startTime == TimeOfDay.now()
                                        ? 'Select End Date'
                                        : DateFormat('E\t dd MMM yyyy')
                                            .format(endDate)
                                            .toString(),
                                    // nama: 'Select End Date and Time',
                                    icon: const Icon(
                                        Icons.calendar_today_outlined),
                                    warna: Colors.red,
                                    onPressed: () async {
                                      DateTime? dateEnd = await showDatePicker(
                                          context: context,
                                          initialDate: initialDate,
                                          firstDate: DateTime(2020),
                                          lastDate: DateTime(2050),
                                          confirmText: 'SELECT END DATE');
                                      if (dateEnd == null) return;

                                      setState(() => endDate = dateEnd);
                                    },
                                  ),
                                  ButtonIcon(
                                      nama: endTime == TimeOfDay.now()
                                          ? 'Pick End Time'
                                          : endTime.toString(),
                                      warna: Colors.red,
                                      onPressed: () async {
                                        TimeOfDay? timeEnd =
                                            await showTimePicker(
                                                context: context,
                                                confirmText: 'SELECT END TIME',
                                                initialTime: TimeOfDay.now());
                                        if (timeEnd == null) return;
                                        setState(() {
                                          timeEnd = endTime;
                                        });
                                      },
                                      icon:
                                          const Icon(Icons.access_time_rounded))
                                ],
                              ),
                            ],
                          ),

                          // ignore: todo
                          //TODO three bottom
                          // ignore: todo
                          //TODO One is schedule activity
                          // ignore: todo
                          //TODO second is draft
                          // ignore: todo
                          //TODO third is cancel
                        ])
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
