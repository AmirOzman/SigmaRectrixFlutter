// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:odoo_rpc/odoo_rpc.dart';
import 'package:sigma_crm/model/reason_class.dart';

class LostReason extends StatefulWidget {
  final OdooClient client;
  final OdooSession session;
  const LostReason(this.client, this.session, {Key? key}) : super(key: key);

  @override
  State<LostReason> createState() => _LostReasonState();
}

class _LostReasonState extends State<LostReason> {
  late GetReason _selected;
  @override
  Widget build(BuildContext context) {
    Future<dynamic> fetchReasons() async {
      return widget.client.callKw(
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
    }

    Widget builddropdownButton(Map<String, dynamic> record) {
      return DropdownButton(
        items: record['name'],
        value: record['id'],
        onChanged: (Object? value) {
          int reason_no = 1;
          setState(
            () {
              reason_no = int.parse(record['id']);
            },
          );

          //widget.client.callKw({'model': 'crm.lead', 'method': 'write'});
          widget.client.callKw({
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
          });
        },
      );
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
                // return DropdownButton<GetReason>(items: results.map((result)),)
                return DropdownButton<GetReason>(
                  items:
                      //snapshot.data.results.map((GetReason dropDownStringItem)
                      snapshot.data((GetReason dropDownStringItem) {
                    return DropdownMenuItem<GetReason>(
                        value: dropDownStringItem,
                        child: Text(dropDownStringItem.name.toString()));
                  }),
                  onChanged: (value) {
                    setState(() {
                      _selected = value!;
                    });
                  },
                  value: _selected,
                );
              }
          }
        });
  }
}
