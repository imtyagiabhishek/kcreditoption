
class BankIncomeDetailsRequest {
  String? accountNumber;
  String? holderName;
  String? branchName;
  String? bankName;
  String? ifsc;
  String? workNature;
  String? monthIncome;
  String?jobType;


  BankIncomeDetailsRequest({ this.accountNumber,  this.holderName,this.branchName,this.bankName,this.ifsc,this.workNature,this.monthIncome,this.jobType});

  BankIncomeDetailsRequest.fromJson(Map<String, dynamic> json) {
   accountNumber = json['accountNumber'];
   holderName = json['holderName'];
   branchName = json['branchName'];
   bankName = json['bankName'];
   ifsc = json['ifsc'];
   workNature = json['workNature'];
   monthIncome=json['monthIncome'];
   jobType=json['jobType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accountNumber'] = this.accountNumber;
    data['holderName'] = this.holderName;
    data['branchName'] = this.branchName;
    data['bankName'] = this.bankName;
    data['ifsc'] = this.ifsc;
    data['workNature'] = this.workNature;
    data['monthIncome'] = this.monthIncome;
    data['jobType'] = this.jobType;
    return data;
 }
}