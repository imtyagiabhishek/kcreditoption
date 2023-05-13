class PersonalDetail {
  String? id;
  String? profile;
  String? profileNmae;
  String? name;
  String? dob;
  String? gender;
  String? email;
  String? address;
  String? state;
  String? district;
  String? city;
  String? pincode;
  String? loanPanelId;

  PersonalDetail(
      {this.id,
        this.profile,
        this.profileNmae,
        this.name,
        this.dob,
        this.gender,
        this.email,
        this.address,
        this.state,
        this.district,
        this.city,
        this.pincode,
        this.loanPanelId});

  PersonalDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    profile = json['profile'];
    profileNmae = json['profileNmae'];
    name = json['name'];
    dob = json['dob'];
    gender = json['gender'];
    email = json['email'];
    address = json['address'];
    state = json['state'];
    district = json['district'];
    city = json['city'];
    pincode = json['pincode'];
    loanPanelId = json['loanPanelId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['profile'] = this.profile;
    data['profileNmae'] = this.profileNmae;
    data['name'] = this.name;
    data['dob'] = this.dob;
    data['gender'] = this.gender;
    data['email'] = this.email;
    data['address'] = this.address;
    data['state'] = this.state;
    data['district'] = this.district;
    data['city'] = this.city;
    data['pincode'] = this.pincode;
    data['loanPanelId'] = this.loanPanelId;
    return data;
  }
}