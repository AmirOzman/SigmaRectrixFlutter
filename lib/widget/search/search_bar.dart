import 'package:flutter/material.dart';
import 'package:odoo_rpc/odoo_rpc.dart';

class CustomSearchDelegate extends SearchDelegate {
  //null check implementation on geting client from previous activity
  late OdooClient client;
  Future<dynamic> customerName() async {
    return client.callKw({
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
          'email_from',
          'create_date',
          'partner_name',
          'partner_id',
          'description',
          //TODO show priority
          'priority',
        ],
      },
    });
  }

  List<String> searchTerms = ['apple', 'orange', 'donut'];
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    Stream<dynamic>;
    List<String> matchQuery = [];
    for (var fruit in searchTerms) {
      if (fruit.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var fruit in searchTerms) {
      if (fruit.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }
}
