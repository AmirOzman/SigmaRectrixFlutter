class GetPartner {
  final String? name;
  final String? email;
  final int? id;

  const GetPartner({
    this.name,
    this.id,
    this.email,
  });
  static GetPartner fromJson(Map<String, dynamic> json) => GetPartner(
      name: json['name'],
      id: json['id'],
      email: json['email'] == false
          ? json['email'] = ''
          : json['email'].toString());
}
