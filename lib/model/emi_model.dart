class Emis {
  String? id;
  int? payment;
  String? dueDate;
  String? remark;
  String? loanPanelId;
  String? createdAt;
  String? updatedAt;

  Emis(
      {this.id,
        this.payment,
        this.dueDate,
        this.remark,
        this.loanPanelId,
        this.createdAt,
        this.updatedAt});

  Emis.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    payment = json['payment'];
    dueDate = json['dueDate'];
    remark = json['remark'];
    loanPanelId = json['loanPanelId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['payment'] = this.payment;
    data['dueDate'] = this.dueDate;
    data['remark'] = this.remark;
    data['loanPanelId'] = this.loanPanelId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}