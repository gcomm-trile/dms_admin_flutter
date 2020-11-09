// class Store {
//   String id;
//   String name;
//   String owner;
//   String phone;
//   String address;
//   String street;
//   String ward;
//   String district;
//   String province;
//   double gpsLatitude;
//   double gpsLongitude;
//   Null storeLocation;
//   bool isActive;
//   String modifiedOn;
//   Null donViHanhChanh;

//   Store(
//       {this.id,
//       this.name,
//       this.owner,
//       this.phone,
//       this.address,
//       this.street,
//       this.ward,
//       this.district,
//       this.province,
//       this.gpsLatitude,
//       this.gpsLongitude,
//       this.storeLocation,
//       this.isActive,
//       this.modifiedOn,
//       this.donViHanhChanh});

//   Store.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     owner = json['owner'];
//     phone = json['phone'];
//     address = json['address'];
//     street = json['street'];
//     ward = json['ward'];
//     district = json['district'];
//     province = json['province'];
//     gpsLatitude = json['gps_latitude'];
//     gpsLongitude = json['gps_longitude'];
//     storeLocation = json['store_location'];
//     isActive = json['is_active'];
//     modifiedOn = json['modifiedOn'];
//     donViHanhChanh = json['donViHanhChanh'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['owner'] = this.owner;
//     data['phone'] = this.phone;
//     data['address'] = this.address;
//     data['street'] = this.street;
//     data['ward'] = this.ward;
//     data['district'] = this.district;
//     data['province'] = this.province;
//     data['gps_latitude'] = this.gpsLatitude;
//     data['gps_longitude'] = this.gpsLongitude;
//     data['store_location'] = this.storeLocation;
//     data['is_active'] = this.isActive;
//     data['modifiedOn'] = this.modifiedOn;
//     data['donViHanhChanh'] = this.donViHanhChanh;
//     return data;
//   }
// }
