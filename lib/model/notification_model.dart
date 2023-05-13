class NotificationModel {

  int? id;
  String? title;
  String? desc;
  String? createdAt;
  String? accountId;

  NotificationModel({this.id, this.title, this.desc, this.createdAt, this.accountId});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    desc = json['desc'];
    createdAt = json['createdAt'];
    accountId = json['accountId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['desc'] = this.desc;
    data['createdAt'] = this.createdAt;
    data['accountId'] = this.accountId;
    return data;
  }
}

