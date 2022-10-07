class GetLosts {
  final int? id;
  final int? lostReasonID;
  final int? createUID;
  final DateTime? createDate;
  final int? writeUID;
  final DateTime? writeDate;

  GetLosts(
      {this.id,
      this.lostReasonID,
      this.createUID,
      this.createDate,
      this.writeUID,
      this.writeDate});

  GetLosts.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        lostReasonID = json['lost_reason_id'],
        createUID = json['create_uid'],
        createDate = json['create_date'],
        writeUID = json['write_uid'],
        writeDate = json['write_date'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'lost_reason_id': lostReasonID,
        'create_uid': createUID,
        'create_date': createDate,
        'write_uid': writeUID,
        'write_date': writeDate,
      };
}
