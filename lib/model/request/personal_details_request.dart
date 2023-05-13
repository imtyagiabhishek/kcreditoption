class PersonalDetailsRequest {
  String? name;
  String? dob;
  String? gender;
  String? email;
  String? address;
  String? state;
  String? district;
  String? city;
  String? pincode;


  PersonalDetailsRequest({ this.name,  this.dob,  this.gender,  this.email,this.address,this.state,this.district,this.city,this.pincode});

  PersonalDetailsRequest.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    dob = json['dob'];
    gender = json['gender'];
    email = json['email'];
    address = json['address'];
    state = json['state'];
    district = json['district'];
    city = json['city'];
    pincode = json['pincode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['dob'] = this.dob;
    data['gender'] = this.gender;
    data['email'] = this.email;
    data['address'] = this.address;
    data['state'] = this.state;
    data['district'] = this.district;
    data['city'] = this.city;
    data['pincode'] = this.pincode;

    return data;
  }
}