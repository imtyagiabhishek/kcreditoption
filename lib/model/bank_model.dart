class BankModel {
  String? id;
  String? accountNumber;
  String? holderName;
  String? branchName;
  String? bankName;
  String? ifsc;
  String? upi;
  bool? status;

  BankModel(
      {this.id,
        this.accountNumber,
        this.holderName,
        this.branchName,
        this.bankName,
        this.ifsc,
        this.upi,
        this.status});

  BankModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    accountNumber = json['accountNumber'];
    holderName = json['holderName'];
    branchName = json['branchName'];
    bankName = json['bankName'];
    ifsc = json['ifsc'];
    upi = json['upi'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['accountNumber'] = this.accountNumber;
    data['holderName'] = this.holderName;
    data['branchName'] = this.branchName;
    data['bankName'] = this.bankName;
    data['ifsc'] = this.ifsc;
    data['upi'] = this.upi;
    data['status'] = this.status;
    return data;
  }
}

