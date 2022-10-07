import 'package:flutter/material.dart';
import 'package:odoo_rpc/odoo_rpc.dart';

class NewRecord extends StatelessWidget {
  final OdooClient client;
  final String tableName;
  const NewRecord(this.tableName, {Key? key, required this.client})
      : super(key: key);

  Future buildRecord(BuildContext context) {
    return client.callKw({
      'model': tableName,
      'method': 'create',
      'args': [],
      'kwargs': [],
      'context': {'bin_size': true},
      'domain': [],
      'fields': [],
      'limit': 80,
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Card();
  }
}
