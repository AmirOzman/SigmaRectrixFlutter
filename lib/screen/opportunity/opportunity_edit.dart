import 'package:flutter/material.dart';
import 'package:sigma_crm/widget/widget.dart';

class OpportunityEdit extends StatefulWidget {
  final OdooClient client;
  final OdooSession session;
  final int clientId;
  final String clientName;
  final String description;
  final double rating;
  // final double? rate;

  const OpportunityEdit(
    this.client,
    this.session,
    this.rating, {
    Key? key,
    required this.clientId,
    required this.clientName,
    required this.description,
  }) : super(key: key);

  @override
  State<OpportunityEdit> createState() => _OpportunityEditState();
}

class _OpportunityEditState extends State<OpportunityEdit> {
  @override
  Widget build(BuildContext context) {
    final opportunityName = TextEditingController();
    final expectedRevenue = TextEditingController();
    // final double rating;
    return Scaffold(
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          child: Center(
            child: ButtonIcon(
                nama: 'Submit',
                onPressed: () {},
                icon: const Icon(Icons.done_outline_rounded)),
          ),
        ),
        body: CustomScrollView(
          slivers: [
            SliverAppBarCustom(
              client: widget.client,
              session: widget.session,
              tajuk: Text(widget.clientName),
              float: false,
              log: false,
              find: false,
            ),
            SliverFillRemaining(
              child: SingleChildScrollView(
                child: PaddingConst(
                  child: Center(
                    child: Column(children: [
                      TextForm(
                        controller: opportunityName,
                        label: 'Opportunity Name',
                        kb: TextInputType.multiline,
                      ),
                      TextForm(
                        controller: expectedRevenue,
                        label: 'Expected Revenue',
                        kb: TextInputType.number,
                      ),
                      ButtonIcon(
                        nama: 'Date Dateline',
                        onPressed: () {},
                        icon: const Icon(Icons.calendar_month_rounded),
                      ),
                      // ignore: todo
                      //TODO ratingbuilder
                      // RatingBar.builder(
                      //   initialRating: widget.rate ?? 0,
                      //   minRating: 0,
                      //   direction: Axis.horizontal,
                      //   allowHalfRating: false,
                      //   itemCount: 3,
                      //   itemSize: 30,
                      //   itemPadding:
                      //       const EdgeInsets.symmetric(horizontal: 4.0),
                      //   itemBuilder: (context, _) => const Icon(
                      //     Icons.star,
                      //     color: Color.fromARGB(255, 179, 12, 48),
                      //   ),
                      //   updateOnDrag: true,
                      //   onRatingUpdate: (rating) {
                      //     if (mounted) {
                      //       setState(() {
                      //         this.rating = rating;
                      //       });
                      //     }
                      //     print(
                      // ignore: todo
                      //         rating); //TODO Remove this later, this is for testing only 10 march @hafizalwi
                      //   },
                      // ),

                      // TextForm(controller: dateDateline, label: label),
                      // ignore: todo
                      //TODO expected revenue field name "planned_revenue"
                      // ignore: todo
                      //TODO expected closing field name: "date_dateline"
                      // ignore: todo
                      //TODO tags field name: "tag_ids" relation crm.lead.tag
                      // ButtonIcon(
                      //     nama: 'Save',
                      //     onPressed: () {
                      //       widget.client.callKw({
                      //         'model': 'crm.lead',
                      //         'method': 'write',
                      //         'args': [{
                      //           'name':,
                      //           'rating':
                      //         }]
                      //       });
                      //     },
                      //     icon: const Icon(Icons.save))
                    ]
                        //Button
                        ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
