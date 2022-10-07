import 'package:odoo_rpc/odoo_rpc.dart';

late final OdooClient client;

class GetReason {
  final String? name;
  final int? id;

  const GetReason({
    this.name,
    this.id,
  });

  static GetReason fromJson(Map<String, dynamic> json) =>
      GetReason(name: json['name'], id: json['id']);
}

class ReasonApi {
  Future<List<GetReason>> getReasonSuggestion(List query) async {
    final reason = await client.callKw({
      'model': 'crm.lost.reason',
      'method': 'search_read',
      'args': [],
      'kwargs': {
        'context': {'bin_size': true},
        'fields': [
          'id',
          'name',
        ],
      }
    });
    return reason.map((json) => GetReason.fromJson(json)).toList();
  }
}
