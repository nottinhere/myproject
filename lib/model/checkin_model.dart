class CheckinModel {
  String? id;
  String? staff;
  String? thisdate;
  String? timecheck;
  String? invoice;
  String? sod;
  String? siv;
  String? dpmformpoint;
  String? sqindate;

  CheckinModel(
      {this.id,
      this.staff,
      this.thisdate,
      this.timecheck,
      this.invoice,
      this.sod,
      this.siv,
      this.dpmformpoint,
      this.sqindate});

  CheckinModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    staff = json['staff'];
    thisdate = json['thisdate'];
    timecheck = json['timecheck'];
    invoice = json['invoice'];
    sod = json['sod'];
    siv = json['siv'];
    dpmformpoint = json['dpmformpoint'];
    sqindate = json['sqindate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['staff'] = this.staff;
    data['thisdate'] = this.thisdate;
    data['timecheck'] = this.timecheck;
    data['invoice'] = this.invoice;
    data['sod'] = this.sod;
    data['siv'] = this.siv;
    data['dpmformpoint'] = this.dpmformpoint;
    data['sqindate'] = this.sqindate;
    return data;
  }
}
