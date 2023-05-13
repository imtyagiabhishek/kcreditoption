class BniDetail {
  String? id;
  String? accountNumber;
  String? holderName;
  String? branchName;
  String? bankName;
  String? ifsc;
  String? workNature;
  int? monthIncome;
  String? jobType;
  String? passbook;
  String? passbookName;
  String? salarySlip;
  String? salarySlipName;
  String? loanPanelId;

  BniDetail(
      {this.id,
        this.accountNumber,
        this.holderName,
        this.branchName,
        this.bankName,
        this.ifsc,
        this.workNature,
        this.monthIncome,
        this.jobType,
        this.passbook,
        this.passbookName,
        this.salarySlip,
        this.salarySlipName,
        this.loanPanelId});

  BniDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    accountNumber = json['accountNumber'];
    holderName = json['holderName'];
    branchName = json['branchName'];
    bankName = json['bankName'];
    ifsc = json['ifsc'];
    workNature = json['workNature'];
    monthIncome = json['monthIncome'];
    jobType = json['jobType'];
    passbook = json['passbook'];
    passbookName = json['passbookName'];
    salarySlip = json['salarySlip'];
    salarySlipName = json['salarySlipName'];
    loanPanelId = json['loanPanelId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['accountNumber'] = this.accountNumber;
    data['holderName'] = this.holderName;
    data['branchName'] = this.branchName;
    data['bankName'] = this.bankName;
    data['ifsc'] = this.ifsc;
    data['workNature'] = this.workNature;
    data['monthIncome'] = this.monthIncome;
    data['jobType'] = this.jobType;
    data['passbook'] = this.passbook;
    data['passbookName'] = this.passbookName;
    data['salarySlip'] = this.salarySlip;
    data['salarySlipName'] = this.salarySlipName;
    data['loanPanelId'] = this.loanPanelId;
    return data;
  }
}