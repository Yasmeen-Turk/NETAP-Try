class PermissionModel {
  String? reqId;
  String? reqEmail;
  String? date;
  String? reason;
  String? time;
  PermissionModel({
    this.reqId,
    this.reqEmail,
    this.date,
    this.reason,
    this.time,
  });
  toMap() {
    return {
      'reqId': this.reqId,
      'reqEmail': this.reqEmail,
      'Date': this.date,
      'Reason': this.reason,
      'Time': this.time,
    };
  }
}
