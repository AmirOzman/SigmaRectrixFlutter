// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:sigma_crm/model/reason_class.dart';
import 'package:sigma_crm/screen/screen.dart';
import 'package:sigma_crm/widget/widget.dart';
import 'package:sigma_crm/api/api.dart';

class LostForm extends StatefulWidget {
  final OdooClient client;
  final OdooSession session;
  final String clientName;
  final String newLost;
  final String createLost;

  const LostForm({
    Key? key,
    required this.client,
    required this.session,
    required this.clientName,
    required this.newLost,
    required this.createLost,
  }) : super(key: key);

  @override
  State<LostForm> createState() => _LostFormState();
}

class _LostFormState extends State<LostForm> {
  TextEditingController userEditTextController = new TextEditingController();
  final createLost = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    try {
      userEditTextController.dispose();
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBarCustom(
            client: widget.client,
            session: widget.session,
            tajuk: Text('${widget.clientName}'),
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
                        Center(
                          child: Column(children: [
                            Text('LOST REASON'),
                            SpacingVertical(10),
                            Container(
                              width: 60,
                              height: 60,
                              child: SingleChildScrollView(),
                            ),
                            LostReason(widget.client, widget.session,
                                userEditTextController),
                            _createNew(context),
                            //_submitButton(context)
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

Widget _createNew(context) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: RichText(
      text: TextSpan(
        text: "Create ",
        style: const TextStyle(color: Colors.black),
        children: [
          TextSpan(
            text: "new lost",
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                addLostBottom(context);
              },
            style: const TextStyle(
              color: Colors.blue,
            ),
            children: const [
              TextSpan(
                text: " profile",
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

//Widget _submitButton(context) {
//  return Padding(
//    padding: const EdgeInsets.all(8.0),
//    child: RichText(
//      text: TextSpan(
//        text: "Submit",
//        recognizer: TapGestureRecognizer()
//          ..onTap = () {
//            submitLostBottom(context);
//          },
//        style: const TextStyle(
//          color: Colors.blue,
//        ),
//      ),
//    ),
//  );
//}

//Widget _submitButton(context) {
//  return Expanded(
//    flex: 1,
//    child: Align(
//      alignment: Alignment.bottomCenter,
//      child: ButtonText(
//        lebar: 0.4,
//        nama: 'Submit',
//        warna: Colors.black,
//        onPressed: () {
//          client?.callKw(
//            {
//              'model': 'crm.lead.lost',
//              'method': 'write',
//              'args': [
//                record['id'],
//                record['lost.reason.id'],
//                {
//                  'type': 'lost',
//                }
//              ],
//              'kwargs': {},
//            },
//          );
//          Navigator.of(context).pop();
//          ScaffoldMessenger.of(context).showSnackBar(
//            const SnackBar(
//              content: Text(
//                'Lost Submitted',
//                textAlign: TextAlign.center,
//              ),
//            ),
//          );
//        },
//      ),
//    ),
//  );
//}

//NEW
//Future submitLostBottom(context) => showModalBottomSheet(
//    context: context,
//    shape: const RoundedRectangleBorder(
//      borderRadius: BorderRadius.vertical(
//        top: Radius.circular(20),
//      ),
//    ),
//    clipBehavior: Clip.antiAliasWithSaveLayer,
//    builder: (BuildContext context) {
//      return Padding(
//        padding: MediaQuery.of(context).viewInsets,
//        child: Container(
//          child: Padding(
//            padding: const EdgeInsets.all(8.0),
//            child: Column(
//              children: [
//                Expanded(
//                  flex: 5,
//                  child: SingleChildScrollView(
//                    child: Column(
//                      children: [
//                        TextForm(
//                          controller: submitLost,)
//                      ],
//                    ),
//                  ),
//                ),
//              ],
//            ),
//          ),
//        ),
//      );
//    });

Future addLostBottom(context) => showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(20),
      ),
    ),
    clipBehavior: Clip.antiAliasWithSaveLayer,
    builder: (BuildContext context) {
      var createNewLost = TextEditingController();
      return Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Expanded(
                  flex: 5,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // ignore: todo
                        //TODO radiobutton for selecting between company or individual
                        // ignore: todo
                        //TODO upload customer image feature
                        TextForm(
                          controller: createNewLost,
                          label: "Description",
                          kotak: true,
                        ),
                        const SpacingPixel(h: 20),

                        //Visibility(visible:child: CustomTextFormField(controller: newJobPos, label: "Job Position")),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: ButtonText(
                      lebar: 0.4,
                      nama: 'Submit',
                      warna: Colors.black,
                      onPressed: () async {
                        await client?.callKw({
                          'model': 'crm.lost.reason',
                          'method': 'create',
                          'args': [
                            {
                              'name': createNewLost.text,
                            }
                          ],
                          'kwargs': {},
                        });
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'New Lost Created',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
