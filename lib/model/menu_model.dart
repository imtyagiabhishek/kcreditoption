class MenuModel {
  int? id;
  String? name;
  String? url;
  String? image;
  String? imageName;
  bool? status;

  MenuModel(
      {this.id, this.name, this.url, this.image, this.imageName, this.status});

  MenuModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    url = json['url'];
    image = json['image'];
    imageName = json['imageName'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['url'] = this.url;
    data['image'] = this.image;
    data['imageName'] = this.imageName;
    data['status'] = this.status;
    return data;
  }
}

