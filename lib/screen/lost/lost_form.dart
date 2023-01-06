// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:sigma_crm/model/reason_class.dart';
import 'package:sigma_crm/screen/screen.dart';
import 'package:sigma_crm/widget/widget.dart';
import 'package:sigma_crm/api/api.dart';
import 'package:dropdown_search/dropdown_search.dart';

class LostForm extends StatefulWidget {
  final OdooClient client;
  final OdooSession session;
  final String clientName;
  final String newLost;
  final String createLost;
  final int id;

  const LostForm({
    Key? key,
    required this.client,
    required this.session,
    required this.clientName,
    required this.newLost,
    required this.createLost,
    required this.id,
  }) : super(key: key);

  @override
  State<LostForm> createState() => _LostFormState();
}

class _LostFormState extends State<LostForm> {
  TextEditingController userEditTextController = TextEditingController();
  final createLost = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    //  userEditTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future<dynamic> fetchLeads() async {
      return widget.client.callKw({
        'model': 'crm.lead',
        'method': 'search_read',
        'args': [],
        'kwargs': {
          'context': {'bin_size': true},
          'domain': [
            ['type', '=', 'lead'],
            // ['partner_id', '!=', null]
          ],
          'fields': [
            'id',
            'name',
            'active',
            'email_from',
            'description',
            'create_date',
            'partner_name',
            'partner_id',
            // ignore: todo
            // TODO show priority
            'priority',
          ],
        },
      });
    }

    //final ButtonStyle style =
    //    ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));
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
            delegate: SliverChildListDelegate(
              [
                GestureDetector(
                  onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
                  child: SingleChildScrollView(
                    child: Stack(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            vertical: screenSize.height * 0.1,
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
                                _futurebuilder_fetchreasons(),
                                _createNew(context),
                                //_submitButton(context)
                              ]),
                            )
                          ]),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _futurebuilder_fetchreasons() {
    Widget _builddropdownsearch(record) {
      String? dropdownValueString;
      //String? displayname;
      List testlist = [];
      List namelist = [];
      int? indexOfLostReason;
      final ButtonStyle style =
          ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

      for (int index = 0; index < record.length; index++) {
        //testlist.add(data[index].name.toString());
        testlist.add(record[index].id.toString());
        print("data inside for loop" + testlist.toString());
      }

      for (int index = 0; index < record.length; index++) {
        //testlist.add(data[index].name.toString());

        namelist.add(record[index].name.toString());
        print("name inside for loop" + namelist.toString());
      }

      print("data outside for loop" + testlist.toString());

      return Column(
        children: [
          Container(
            child: DropdownSearch<String>(
              selectedItem: dropdownValueString,
              items: namelist
                  .cast(), //["Brazil", "Italy", "Cannada", "malay", "america"],
              dropdownDecoratorProps: DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(
                  labelText: "Select",
                  hintText: "please select",
                ),
              ),
              onChanged: (data) {
                dropdownValueString = // "too expensive"
                    data; // String data = We don't have people/skills > 1
                print("what is dropdownvaluestring name: " +
                    dropdownValueString!); // String dropdownValueString = We don't have people/skills > 1

                indexOfLostReason = namelist.indexWhere(
                    (item) => item == dropdownValueString.toString());

                print("what is indexoflost" + indexOfLostReason.toString());

                //if (indexOfLostReason! >= 0)
                //if (indexOfLostReason! >= 0 == true)
                //  indexOfLostReason! +
                //      1; //plus one from index to turn it into Id
                //print("what is indexoflost after plus one " +
                //    indexOfLostReason.toString());
              },
              popupProps: PopupProps.menu(
                  showSelectedItems: true,
                  showSearchBox: true,
                  searchFieldProps: TextFieldProps(
                      controller: userEditTextController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.clear),
                      ))),
            ),
          ),
          SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Center(
                child: Column(
                  children: <Widget>[
                    ElevatedButton(
                      style: style,
                      onPressed: () {
                        widget.client.callKw(
                          {
                            'model': 'crm.lead',
                            'method': 'write',
                            'args': [
                              widget.id, // id
                              {
                                'active': false, //string
                                'lost_reason': (indexOfLostReason =
                                    indexOfLostReason! + 1), //string
                              },
                            ],
                            'kwargs': {},
                          },
                        );

                        print("new index of indexoflostreason " +
                            indexOfLostReason.toString());

                        widget.client.callKw({
                          'model': 'crm.lead.lost',
                          'method': 'create',
                          'args': [
                            {
                              //lost reason id should be valuedropdown string(id)
                              'lost_reason_id': indexOfLostReason,
                            },
                          ],
                          'kwargs': {},
                        });

                        // print("testing result string: " +
                        //     dropdownValueString
                        //         .toString()); //desired result will print either one of > too expensive, We don't have people/skills]
                      },
                      child: const Text('Submit'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    }

    Future<List> fetchReasons() async {
      List reasonlist;

      var lostreason = await widget.client.callKw(
        {
          'model': 'crm.lost.reason',
          'method': 'search_read',
          'args': [],
          'kwargs': {
            'context': {'bin_size': true},
            'fields': [
              'id',
              'name',
            ],
          },
        },
      );
      reasonlist = lostreason;
      print("reasonlist" + reasonlist.toString());

      return reasonlist.map((json) => GetReason.fromJson(json)).toList();
    }

    return FutureBuilder(
        future: fetchReasons(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Text('none');
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator.adaptive(),
              );
            case ConnectionState.active:
              return Text('');
            case ConnectionState.done:
              if (snapshot.hasError) {
                return Text(
                  '${snapshot.hasError}',
                  style: TextStyle(
                    color: Colors.red[400],
                  ),
                );
              } else {
                if (snapshot.hasData) {
                  // return DropdownButton<GetReason>(items: results.map((result)),)
                  return _builddropdownsearch(snapshot.data);
                  //kau punya dropdown
                } else
                  return Text('Please choose');
              }
          }
        });
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
//  return Expanded(
//    flex: 1,
//    child: Align(
//      alignment: Alignment.bottomCenter,
//      child: ButtonText(
//        lebar: 0.4,
//        nama: 'Submit',
//        warna: Colors.black,
//        onPressed: () async {
//          var record;
//          client?.callKw(
//            {
//              'model': 'crm.lead.lost',
//              'method': 'write',
//              'args': [
//                record['id'],
//                {
//                  'type': 'lost',
//                }
//              ],
//              'kwargs': {},
//            },
//          );
//
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
                        TextForm(
                          controller: createNewLost,
                          label: "Description",
                          kotak: true,
                        ),
                        const SpacingPixel(h: 20),
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
