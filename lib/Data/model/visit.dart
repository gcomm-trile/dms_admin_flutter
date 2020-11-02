import 'package:dms_admin/data/model/image_s3.dart';
import 'package:dms_admin/data/model/order.dart';
import 'package:dms_admin/data/model/store.dart';

class Visit {
  String id;
  String seq;
  String storeId;
  Store store;
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
      {this.id,
      this.seq,
      this.storeId,
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
      this.locationCheckoutLong,
      this.store});

  Visit.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    seq = json['seq'];

    storeId = json['store_id'];
    store = json['store'] != null ? new Store.fromJson(json['store']) : null;

    isOpened = json['is_opened'];
    feedBack = json['feed_back'];
    duration = json['duration'];

    createdOn = json['created_on'];
    createdByName = json['created_by_name'];
    order = json['order'] != null ? new Order.fromJson(json['order']) : null;
    if (json['checkin_images'] != null) {
      checkinImages = new List<ImageS3>();
      json['checkin_images'].forEach((v) {
        checkinImages.add(new ImageS3.fromJson(v));
      });
    }
    if (json['checkout_images'] != null) {
      checkoutImages = new List<ImageS3>();
      json['checkout_images'].forEach((v) {
        checkoutImages.add(new ImageS3.fromJson(v));
      });
    }

    locationCheckinLat = json['location_checkin_lat'];
    locationCheckinLong = json['location_checkin_long'];
    locationCheckoutLat = json['location_checkout_lat'];
    locationCheckoutLong = json['location_checkout_long'];
  }
}
