class KYCDetailsRequest {
  String? aadharNumber;
  String? panNumber;


  KYCDetailsRequest({ this.aadharNumber,  this.panNumber});

  KYCDetailsRequest.fromJson(Map<String, dynamic> json) {
    aadharNumber = json['aadharNumber'];
    panNumber = json['panNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['aadharNumber'] = this.aadharNumber;
    data['panNumber'] = this.panNumber;

    return data;
  }
}