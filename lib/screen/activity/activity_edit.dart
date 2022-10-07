import 'package:flutter/material.dart';
import 'package:sigma_crm/widget/widget.dart';

class ActivityEdit extends StatefulWidget {
  final OdooClient client;
  final OdooSession session;
  final String title;
  final String location;
  final String partnerName;
  //final String attendee;

  const ActivityEdit(
      // this.client, this.session,
      {Key? key,
      required this.client,
      required this.session,
      required this.title,
      required this.location,
      required this.partnerName})
      : super(key: key);

  @override
  State<ActivityEdit> createState() => _ActivityEditState();
}

class _ActivityEditState extends State<ActivityEdit> {
  final title = TextEditingController();
  final location = TextEditingController();
  final attendee = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          bottomNavigationBar: BottomAppBar(
            shape: const CircularNotchedRectangle(),
            child: ButtonIcon(
                nama: 'Submit',
                onPressed: () {},
                icon: const Icon(Icons.done_outline_rounded)),
          ),
          body: CustomScrollView(
            slivers: [
              SliverAppBarCustom(
                client: widget.client,
                session: widget.session,
                tajuk: const Text('Edit'),
                float: true,
                log: false,
                find: false,
              ),
              SliverFillRemaining(
                child: PaddingConst(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                      TextForm(
                        controller: title,
                        label: 'Metting title',
                        max: null,
                        kotak: true,
                      ),
                      const SpacingPixel(h: 20),
                      TextForm(
                        controller: location,
                        label: 'Location',
                        max: null,
                      ),
                      const SpacingPixel(h: 20),
                      TextForm(controller: attendee, label: 'Attendee'),
                      const SpacingPixel(h: 20),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ButtonIcon(
                            nama: 'StartDate',
                            onPressed: () {},
                            icon: const Icon(Icons.calendar_today_outlined),
                            warna: Colors.green,
                          ),
                          ButtonIcon(
                              nama: 'EndDate',
                              onPressed: () {},
                              icon: const Icon(Icons.calendar_today_outlined),
                              warna: Colors.red),
                        ],
                      )
                    ])),
              )
            ],
          )),
    );
  }
}
