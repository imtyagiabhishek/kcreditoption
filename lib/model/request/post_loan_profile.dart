class LoanProfilePostModel {
  String? holderName;
  String? accountNumber;
  String? bankName;
  String? amount;
  String? interest;
  String? emi;
  int? tenureMonth;
  String? processFee;
  String? loanDate;
  String? accountId;


  LoanProfilePostModel({ this.holderName,  this.accountNumber,  this.bankName, this.amount,this.interest, this.emi,this.tenureMonth, this.processFee, this.loanDate, this.accountId});

  LoanProfilePostModel.fromJson(Map<String, dynamic> json) {
    holderName = json['holderName'];
    accountNumber = json['accountNumber'];
    bankName = json['bankName'];
    amount = json['amount'];
    interest=json['interest'];
    emi= json['emi'];
    tenureMonth=json['tenureMonth'];
    processFee=json['processFee'];
    loanDate=json['loanDate'];
    accountId=json['accountId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['holderName'] = this.holderName;
    data['accountNumber'] = this.accountNumber;
    data['bankName'] = this.bankName;
    data['amount'] = this.amount;
    data['interest']= this.interest;
    data['emi']= this.emi;
    data['tenureMonth']=this.tenureMonth;
    data['processFee']= this.processFee;
    data['loanDate']= this.loanDate;
    data['accountId']= this.accountId;
    return data;
  }
}