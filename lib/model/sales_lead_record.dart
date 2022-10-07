class GetLeads {
  final int? id;
  final String? name;
  final String? parentID;
  final bool? active;
  // final bool? date_action_last;
  // final String? priority;
  final String? email;
  final String? street;
  final String? street2;
  final String? stateID;
  final String? city;
  final String? zip;
  final String? website;
  final String? function;
  final String? phone;
  final String? mobile;

  const GetLeads({
    this.id,
    this.name,
    this.parentID,
    this.active,
    // this.priority,
    this.email,
    this.street,
    this.street2,
    this.stateID,
    this.city,
    this.zip,
    this.website,
    this.function,
    this.phone,
    this.mobile,
  });

  static GetLeads fromJson(Map<String, dynamic> json) => GetLeads(
        name: json['name'],
        //email: json['email'].toString(),
        id: json['id'],
        email: json['email'] == false
            ? json['email'] = ''
            : json['email']
                .toString(), // if it returns false, because idontknow, odoo return false for null in JSON, then set it as ' ', otherwise, set it as its normal value, which is usually String
        street: json['street'] == false
            ? json['street'] = ''
            : json['street'].toString(),
        street2: json['street2'] == false
            ? json['street2'] = ''
            : json['street2'].toString(),
        stateID: json['state_id'] == false
            ? json['state_id'] = ''
            : json['state'].toString(),
        city:
            json['city'] == false ? json['city'] = '' : json['city'].toString(),
        zip: json['zip'] == false ? json['zip'] = '' : json['zip'].toString(),
        website: json['website'] == false
            ? json['website'] = ''
            : json['website'].toString(),
        function: json['function'] == false
            ? json['function'] = ''
            : json['function'].toString(),
        phone: json['phone'] == false
            ? json['phone'] = ''
            : json['phone'].toString(),
        mobile: json['mobile'] == false
            ? json['mobile'] = ''
            : json['mobile'].toString(),
        parentID: json['parent_id'] == false
            ? json['parent_id'] = ''
            : json['parent_id'].toString(),
      );
}
