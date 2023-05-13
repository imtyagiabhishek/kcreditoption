import 'package:kreditoption/model/personal_details.dart';
import 'bni_model.dart';
import 'kyc_details.dart';

class ApplyLoanResponse {
  String? remark;
  String? id;
  int? loanAmount;
  int? loanTenure;
  int? emi;
  int? totalPayment;
  int? interest;
  String? step;
  String? status;
  String? createdAt;
  String? updatedAt;
  ApplyLoanResponse(
      {this.remark,
        this.id,
        this.loanAmount,
        this.loanTenure,
        this.emi,
        this.totalPayment,
        this.interest,
        this.step,
        this.status,
        this.createdAt,
        this.updatedAt});

  ApplyLoanResponse.fromJson(Map<String, dynamic> json) {
    remark = json['remark'];
    id = json['id'];
    loanAmount = json['loanAmount'];
    loanTenure = json['loanTenure'];
    emi = json['emi'];
    totalPayment = json['totalPayment'];
    interest = json['interest'];
    step = json['step'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['remark'] = this.remark;
    data['id'] = this.id;
    data['loanAmount'] = this.loanAmount;
    data['loanTenure'] = this.loanTenure;
    data['emi'] = this.emi;
    data['totalPayment'] = this.totalPayment;
    data['interest'] = this.interest;
    data['step'] = this.step;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }

}



