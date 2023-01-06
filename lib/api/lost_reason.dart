import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
//import 'package:odoo_rpc/odoo_rpc.dart';
import 'package:sigma_crm/model/reason_class.dart';
import 'package:sigma_crm/widget/widget.dart';

class LostReason extends StatefulWidget {
  final OdooClient client;
  final OdooSession session;
  final String? desc;
  final TextEditingController userEditTextController;

  const LostReason(
    this.client,
    this.session,
    this.userEditTextController, {
    Key? key,
    this.desc,
  }) : super(key: key);

  @override
  State<LostReason> createState() => _LostReasonState();
}

class _LostReasonState extends State<LostReason> {
  //late final userEditTextController;
  TextEditingController userEditTextController = TextEditingController();

//@override
//void initState() {
//  userEditTextController = TextEditingController();
//  super.initState();
//}

//@override
//void dispose() {
//  userEditTextController.dispose();
//  super.dispose();
//}

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

  @override
  Widget build(BuildContext context) {
    Widget _builddropdownsearch(data) {
      List testlist = [];

      for (int index = 0; index < data.length; index++) {
        testlist.add(data[index].name);
        print("data inside for loop" + testlist.toString());
        //data['name'];
      }
      print("data outside for loop" + testlist.toString());

      return Container(
        child: DropdownSearch<String>(
          items: testlist
              .cast(), //["Brazil", "Italy", "Cannada", "malay", "america"],
          dropdownDecoratorProps: DropDownDecoratorProps(
            dropdownSearchDecoration: InputDecoration(
              labelText: "Select",
              hintText: "please select",
            ),
          ),
          onChanged: print,

          popupProps: PopupProps.menu(
              showSelectedItems: true,
              showSearchBox: true,
              searchFieldProps: TextFieldProps(
                  //controller: userEditTextController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.clear),
                  ))),
        ),
      );
    }

    //widget.client.callKw({'model': 'crm.lead', 'method': 'write'});
    /*widget.client.callKw({
            'model': 'crm.lead',
            'method': 'write',
            'args': [
              record['id'],
              {
                'crm.stage': 9,
                //'lost_reason': reason_no,
                'lost_reason': 1,
              }
            ],
            'kwargs': {
              'context': {'bin_size': true},
            },
          });*/

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
