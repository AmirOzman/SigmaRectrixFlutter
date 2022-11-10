import 'package:odoo_rpc/odoo_rpc.dart';

//late final OdooClient? client;
OdooClient? client;

class GetReason {
  final OdooClient? client;
  final String? name;
  final int? id;

  GetReason({
    this.client,
    this.name,
    this.id,
  });

  factory GetReason.fromJson(Map<String, dynamic> parsedJson) {
    return GetReason(
      name: parsedJson['name'],
      id: parsedJson['id'],
    );
    //static GetReason fromJson(Map<String, dynamic> json) =>
    //  GetReason(name: json['name'], id: json['id']);
  }
}

/*class ReasonApi {
  final int? number;
  final List<GetReason>? getreasons;

  ReasonApi({this.number, this.getreasons});

  factory ReasonApi.fromJson(String cat, Map<String, String> getreasons) {
    return ReasonApi(
      number: number['number'],
      getreasons:
          number['getreasons'].map((m) => GetReason.fromJson(m)).toList(),
    );
  }
}*/

class ReasonApi {
  Future<List<GetReason>> getReasonSuggestion() async {
    List reasonlist;

    final reason = await client?.callKw({
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

    reasonlist = reason;

    return reasonlist.map((json) => GetReason.fromJson(json)).toList();
  }
}
