class LoanTypeModel {
  int? id;
  String? name;
  String? image;
  String? imageName;
  int? roi;
  int? charge;
  bool? status;

  LoanTypeModel({this.id, this.name, this.image, this.imageName,this.roi ,this.charge,this.status});

  LoanTypeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    imageName = json['imageName'];
    roi=json['roi'];
    charge=json['charge'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['imageName'] = this.imageName;
    data['roi']=this.roi;
    data['charge']=this.charge;
    data['status'] = this.status;
    return data;
  }
}

