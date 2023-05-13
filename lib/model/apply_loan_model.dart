import 'package:kreditoption/model/personal_details.dart';
import 'bni_model.dart';
import 'emi_model.dart';
import 'insurance_model.dart';
import 'kyc_details.dart';

class ApplyLoanModel {
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
  List<BniDetail>? bniDetail;
  List<PersonalDetail>? personalDetail;
  List<KycDetail>? kycDetail;
  List<InsuranceDetail>? insuranceDetail;
  List<Emis>? emis;
  ApplyLoanModel(
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
        this.updatedAt,
        this.bniDetail,
        this.insuranceDetail,
        this.kycDetail,
        this.personalDetail,this.emis});

  ApplyLoanModel.fromJson(Map<String, dynamic> json) {
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
    if (json['kycDetail'] != Null) {
      kycDetail = <KycDetail>[];
      json['kycDetail'].forEach((v) {
        kycDetail!.add(KycDetail.fromJson(v));
      });
    }
    if (json['personalDetail'] != Null) {
      personalDetail = <PersonalDetail>[];
      json['personalDetail'].forEach((v) {
        personalDetail!.add(PersonalDetail.fromJson(v));
      });
    }
    if (json['bniDetail'] != null) {
      bniDetail = <BniDetail>[];
      json['bniDetail'].forEach((v) {
        bniDetail!.add(BniDetail.fromJson(v));
      });
    }
    if (json['insuranceDetail'] != null) {
      insuranceDetail = <InsuranceDetail>[];
      json['insuranceDetail'].forEach((v) {
        insuranceDetail!.add(InsuranceDetail.fromJson(v));
      });
    }
    if (json['emis'] != null) {
      emis = <Emis>[];
      json['emis'].forEach((v) {
        emis!.add(Emis.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
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
    if (this.kycDetail != Null) {
      data['kycDetail'] = this.kycDetail!.map((v) => v.toJson()).toList();
    }
    if (this.personalDetail != Null) {
      data['personalDetail'] =
          this.personalDetail!.map((v) => v.toJson()).toList();
    }
    if (this.bniDetail != null) {
      data['bniDetail'] = this.bniDetail!.map((v) => v.toJson()).toList();
    }
    if (this.insuranceDetail != null) {
      data['insuranceDetail'] =
          this.insuranceDetail!.map((v) => v.toJson()).toList();
    }
    if (this.emis != null) {
      data['emis'] = this.emis!.map((v) => v.toJson()).toList();
    }
    return data;
  }

}



