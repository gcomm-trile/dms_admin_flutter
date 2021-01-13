class Vendor {
  String id;
  String name;
  String email;
  String phone;
  String personContact;
  String address;
  String country;
  String province;
  String district;
  String ward;

  Vendor(
      {this.id,
      this.name,
      this.email,
      this.phone,
      this.personContact,
      this.address,
      this.country,
      this.province,
      this.district,
      this.ward});

  Vendor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    personContact = json['person_contact'];
    address = json['address'];
    country = json['country'];
    province = json['province'];
    district = json['district'];
    ward = json['ward'];
  }
}
