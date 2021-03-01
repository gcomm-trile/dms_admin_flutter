import 'package:dms_admin/data/model/store.dart';
import 'package:dms_admin/data/model/image_s3.dart';
import 'package:dms_admin/data/model/order.dart';

class Visit {
  Store store;
  String id;
  String no;
  String storeId;
  String storeName;
  String storeOwner;
  String storePhone;
  String storeAddress;
  String storeStreet;
  String storeWard;
  String storeDistrict;
  String storeProvince;
  double storeGpsLatitude;
  double storeGpsLongitude;
  bool storeIsActive;
  bool isOpened;
  String feedBack;
  int duration;
  String createdOn;
  String createdByName;
  Order order;
  List<ImageS3> checkinImages;
  List<ImageS3> checkoutImages;
  double locationCheckinLat;
  double locationCheckinLong;
  double locationCheckoutLat;
  double locationCheckoutLong;

  Visit(
      {this.store,
      this.id,
      this.no,
      this.storeId,
      this.storeName,
      this.storeOwner,
      this.storePhone,
      this.storeAddress,
      this.storeStreet,
      this.storeWard,
      this.storeDistrict,
      this.storeProvince,
      this.storeGpsLatitude,
      this.storeGpsLongitude,
      this.storeIsActive,
      this.isOpened,
      this.feedBack,
      this.duration,
      this.createdOn,
      this.createdByName,
      this.order,
      this.checkinImages,
      this.checkoutImages,
      this.locationCheckinLat,
      this.locationCheckinLong,
      this.locationCheckoutLat,
      this.locationCheckoutLong});

  Visit.fromJson(Map<String, dynamic> json) {
    store = json['store'] != null ? new Store.fromJson(json['store']) : null;
    id = json['id'];
    no = json['no'];
    storeId = json['store_id'];
    storeName = json['store_name'];
    storeOwner = json['store_owner'];
    storePhone = json['store_phone'];
    storeAddress = json['store_address'];
    storeStreet = json['store_street'];
    storeWard = json['store_ward'];
    storeDistrict = json['store_district'];
    storeProvince = json['store_province'];
    storeGpsLatitude = json['store_gps_latitude'];
    storeGpsLongitude = json['store_gps_longitude'];
    storeIsActive = json['store_is_active'];
    isOpened = json['is_opened'];
    feedBack = json['feed_back'];
    duration = json['duration'];
    createdOn = json['created_on'];
    createdByName = json['created_by_name'];
    order = json['order'] != null ? new Order.fromJson(json['order']) : null;
    if (json['checkin_images'] != null) {
      checkinImages = <ImageS3>[];
      json['checkin_images'].forEach((v) {
        checkinImages.add(new ImageS3.fromJson(v));
      });
    }
    if (json['checkout_images'] != null) {
      checkoutImages = <ImageS3>[];
      json['checkout_images'].forEach((v) {
        checkoutImages.add(new ImageS3.fromJson(v));
      });
    }
    locationCheckinLat = json['location_checkin_lat'];
    locationCheckinLong = json['location_checkin_long'];
    locationCheckoutLat = json['location_checkout_lat'];
    locationCheckoutLong = json['location_checkout_long'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['store'] = this.store;
    data['id'] = this.id;
    data['no'] = this.no;
    data['store_id'] = this.storeId;
    data['store_name'] = this.storeName;
    data['store_owner'] = this.storeOwner;
    data['store_phone'] = this.storePhone;
    data['store_address'] = this.storeAddress;
    data['store_street'] = this.storeStreet;
    data['store_ward'] = this.storeWard;
    data['store_district'] = this.storeDistrict;
    data['store_province'] = this.storeProvince;
    data['store_gps_latitude'] = this.storeGpsLatitude;
    data['store_gps_longitude'] = this.storeGpsLongitude;
    data['store_is_active'] = this.storeIsActive;
    data['is_opened'] = this.isOpened;
    data['feed_back'] = this.feedBack;
    data['duration'] = this.duration;
    data['created_on'] = this.createdOn;
    data['created_by_name'] = this.createdByName;
    data['order'] = this.order;
    data['checkin_images'] = this.checkinImages;
    data['checkout_images'] = this.checkoutImages;
    data['location_checkin_lat'] = this.locationCheckinLat;
    data['location_checkin_long'] = this.locationCheckinLong;
    data['location_checkout_lat'] = this.locationCheckoutLat;
    data['location_checkout_long'] = this.locationCheckoutLong;
    return data;
  }
}

// class Visit {
//   String id;
//   String seq;
//   String storeId;
//   String storeName;
//   String storeOwner;
//   String storePhone;
//   String storeAddress;
//   String storeStreet;
//   String storeWard;
//   String storeDistrict;
//   String storeProvince;
//   double storeGpsLatitude;
//   double storeGpsLongitude;
//   bool storeIsActive;
//   bool isOpened;
//   String feedBack;
//   int duration;
//   String createdOn;
//   String createdByName;
//   Order order;
//   List<ImageS3> checkinImages;
//   List<ImageS3> checkoutImages;
//   double locationCheckinLat;
//   double locationCheckinLong;
//   double locationCheckoutLat;
//   double locationCheckoutLong;

//   Store store;

//   Visit(
//       {this.id,
//       this.seq,
//       this.storeId,
//       this.storeName,
//       this.storeOwner,
//       this.storePhone,
//       this.storeAddress,
//       this.storeStreet,
//       this.storeWard,
//       this.storeDistrict,
//       this.storeProvince,
//       this.storeGpsLatitude,
//       this.storeGpsLongitude,
//       this.storeIsActive,
//       this.isOpened,
//       this.feedBack,
//       this.duration,
//       this.createdOn,
//       this.createdByName,
//       this.order,
//       this.checkinImages,
//       this.checkoutImages,
//       this.locationCheckinLat,
//       this.locationCheckinLong,
//       this.locationCheckoutLat,
//       this.locationCheckoutLong,
//       this.store});

//   Visit.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     seq = json['seq'];

//     storeId = json['store_id'];
//     storeName = json['store_name'];
//     storeOwner = json['store_owner'];
//     storePhone = json['store_phone'];
//     storeAddress = json['store_address'];
//     storeStreet = json['store_street'];
//     storeWard = json['store_ward'];
//     storeDistrict = json['store_district'];
//     storeProvince = json['store_province'];
//     print('hello ' + json['store_gps_latitude']);
//     print(json['store_gps_longitude']);
//     storeGpsLatitude = json['store_gps_latitude'];
//     storeGpsLongitude = json['store_gps_longitude'];

//     storeIsActive = json['store_is_active'];
//     store = json['store'] != null ? new Store.fromJson(json['store']) : null;
//     isOpened = json['is_opened'];
//     feedBack = json['feed_back'];
//     duration = json['duration'];

//     createdOn = json['created_on'];
//     createdByName = json['created_by_name'];
//     order = json['order'] != null ? new Order.fromJson(json['order']) : null;
//     if (json['checkin_images'] != null) {
//       checkinImages = new List<ImageS3>();
//       json['checkin_images'].forEach((v) {
//         checkinImages.add(new ImageS3.fromJson(v));
//       });
//     }
//     if (json['checkout_images'] != null) {
//       checkoutImages = new List<ImageS3>();
//       json['checkout_images'].forEach((v) {
//         checkoutImages.add(new ImageS3.fromJson(v));
//       });
//     }

//     locationCheckinLat = json['location_checkin_lat'];
//     locationCheckinLong = json['location_checkin_long'];
//     locationCheckoutLat = json['location_checkout_lat'];
//     locationCheckoutLong = json['location_checkout_long'];
//   }
// }
