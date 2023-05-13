class LoanApplyRequest {
  String? loanAmount;
  String? loanTenure;
  double? emi;
  double? totalPayment;
  double? interest;
  String? loanTypeId;


  LoanApplyRequest({ this.loanAmount,  this.loanTenure,  this.emi,  this.totalPayment,this.interest,this.loanTypeId});

  LoanApplyRequest.fromJson(Map<String, dynamic> json) {
    loanAmount = json['loanAmount'];
    loanTenure = json['loanTenure'];
    emi = json['emi'];
    totalPayment = json['totalPayment'];
    interest = json['interest'];
    loanTypeId = json['loanTypeId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['loanAmount'] = this.loanAmount;
    data['loanTenure'] = this.loanTenure;
    data['emi'] = this.emi;
    data['totalPayment'] = this.totalPayment;
    data['interest'] = this.interest;
    data['loanTypeId'] = this.loanTypeId;
    return data;
  }
}