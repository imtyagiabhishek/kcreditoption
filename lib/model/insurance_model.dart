class InsuranceDetail {
  String? id;
  String? name;
  String? relation;
  String? dob;
  String? gender;
  int? amount;
  String? loanPanelId;

  InsuranceDetail(
      {this.id,
        this.name,
        this.relation,
        this.dob,
        this.gender,
        this.amount,
        this.loanPanelId});

  InsuranceDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    relation = json['relation'];
    dob = json['dob'];
    gender = json['gender'];
    amount = json['amount'];
    loanPanelId = json['loanPanelId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['relation'] = this.relation;
    data['dob'] = this.dob;
    data['gender'] = this.gender;
    data['amount'] = this.amount;
    data['loanPanelId'] = this.loanPanelId;
    return data;
  }
}
