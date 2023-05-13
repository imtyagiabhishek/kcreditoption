
class InsuranceDetailsRequest {
  String? name;
  String? relation;
  String? dob;
  String? gender;
  String? amount;


  InsuranceDetailsRequest({ this.name,  this.relation,this.dob,this.gender,this.amount});

  InsuranceDetailsRequest.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    relation = json['relation'];
    dob = json['dob'];
    gender = json['gender'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['relation'] = this.relation;
    data['gender'] = this.gender;
    data['dob'] = this.dob;
    data['amount'] = this.amount;
    return data;
 }
}