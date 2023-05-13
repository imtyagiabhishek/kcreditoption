class KycDetail {
  String? id;
  String? aadharNumber;
  String? aadharFront;
  String? aadharFrontName;
  String? aadharBack;
  String? aadharBackName;
  String? panNumber;
  String? panFront;
  String? panFrontName;
  String? panBack;
  String? panBackName;
  String? loanPanelId;

  KycDetail(
      {this.id,
        this.aadharNumber,
        this.aadharFront,
        this.aadharFrontName,
        this.aadharBack,
        this.aadharBackName,
        this.panNumber,
        this.panFront,
        this.panFrontName,
        this.panBack,
        this.panBackName,
        this.loanPanelId});

  KycDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    aadharNumber = json['aadharNumber'];
    aadharFront = json['aadharFront'];
    aadharFrontName = json['aadharFrontName'];
    aadharBack = json['aadharBack'];
    aadharBackName = json['aadharBackName'];
    panNumber = json['panNumber'];
    panFront = json['panFront'];
    panFrontName = json['panFrontName'];
    panBack = json['panBack'];
    panBackName = json['panBackName'];
    loanPanelId = json['loanPanelId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['aadharNumber'] = this.aadharNumber;
    data['aadharFront'] = this.aadharFront;
    data['aadharFrontName'] = this.aadharFrontName;
    data['aadharBack'] = this.aadharBack;
    data['aadharBackName'] = this.aadharBackName;
    data['panNumber'] = this.panNumber;
    data['panFront'] = this.panFront;
    data['panFrontName'] = this.panFrontName;
    data['panBack'] = this.panBack;
    data['panBackName'] = this.panBackName;
    data['loanPanelId'] = this.loanPanelId;
    return data;
  }
}