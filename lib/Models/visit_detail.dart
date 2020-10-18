import 'package:dms_admin/Models/image_s3.dart';

class VisitDetail {
  String id;
  String storeId;
  bool isOpened;
  String feedBack;
  int duration;
  String createdOn;
  String seq;
  Null storeName;
  Null userName;
  Orders orders;
  List<ImagesS3> checkinImages;
  List<ImagesS3> checkoutImages;
  double locationCheckinLat;
  double locationCheckinLong;
  double locationCheckoutLat;
  double locationCheckoutLong;
  double gpsLongitude;
  double gpsLatitude;

  VisitDetail(
      {this.id,
      this.storeId,
      this.isOpened,
      this.feedBack,
      this.duration,
      this.createdOn,
      this.seq,
      this.storeName,
      this.userName,
      this.orders,
      this.checkinImages,
      this.checkoutImages,
      this.locationCheckinLat,
      this.locationCheckinLong,
      this.locationCheckoutLat,
      this.locationCheckoutLong,
      this.gpsLongitude,
      this.gpsLatitude});

  VisitDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    storeId = json['store_id'];
    isOpened = json['is_opened'];
    feedBack = json['feed_back'];
    duration = json['duration'];
    createdOn = json['createdOn'];
    seq = json['seq'];
    storeName = json['store_name'];
    userName = json['user_name'];
    orders =
        json['orders'] != null ? new Orders.fromJson(json['orders']) : null;
    if (json['checkin_images'] != null) {
      checkinImages = new List<ImagesS3>();
      json['checkin_images'].forEach((v) {
        checkinImages.add(new ImagesS3.fromJson(v));
      });
    }
    if (json['checkout_images'] != null) {
      checkoutImages = new List<ImagesS3>();
      json['checkout_images'].forEach((v) {
        checkoutImages.add(new ImagesS3.fromJson(v));
      });
    }
    locationCheckinLat = json['location_checkin_lat'];
    locationCheckinLong = json['location_checkin_long'];
    locationCheckoutLat = json['location_checkout_lat'];
    locationCheckoutLong = json['location_checkout_long'];
    gpsLongitude = json['gps_longitude'];
    gpsLatitude = json['gps_latitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['store_id'] = this.storeId;
    data['is_opened'] = this.isOpened;
    data['feed_back'] = this.feedBack;
    data['duration'] = this.duration;
    data['createdOn'] = this.createdOn;
    data['seq'] = this.seq;
    data['store_name'] = this.storeName;
    data['user_name'] = this.userName;
    if (this.orders != null) {
      data['orders'] = this.orders.toJson();
    }
    if (this.checkinImages != null) {
      data['checkin_images'] =
          this.checkinImages.map((v) => v.toJson()).toList();
    }
    if (this.checkoutImages != null) {
      data['checkout_images'] =
          this.checkoutImages.map((v) => v.toJson()).toList();
    }
    data['location_checkin_lat'] = this.locationCheckinLat;
    data['location_checkin_long'] = this.locationCheckinLong;
    data['location_checkout_lat'] = this.locationCheckoutLat;
    data['location_checkout_long'] = this.locationCheckoutLong;
    data['gps_longitude'] = this.gpsLongitude;
    data['gps_latitude'] = this.gpsLatitude;
    return data;
  }
}

class Orders {
  Null seq;
  Null id;
  Null storeId;
  Null storeName;
  Null storeAddress;
  Null contactPerson;
  Null note;
  Null createdByName;
  String createdOn;
  bool isExportStock;
  String exportStockId;
  Null exportStockName;
  List<Products> products;

  Orders(
      {this.seq,
      this.id,
      this.storeId,
      this.storeName,
      this.storeAddress,
      this.contactPerson,
      this.note,
      this.createdByName,
      this.createdOn,
      this.isExportStock,
      this.exportStockId,
      this.exportStockName,
      this.products});

  Orders.fromJson(Map<String, dynamic> json) {
    seq = json['seq'];
    id = json['id'];
    storeId = json['store_id'];
    storeName = json['store_name'];
    storeAddress = json['store_address'];
    contactPerson = json['contact_person'];
    note = json['note'];
    createdByName = json['created_by_name'];
    createdOn = json['created_on'];
    isExportStock = json['is_export_stock'];
    exportStockId = json['export_stock_id'];
    exportStockName = json['export_stock_name'];
    if (json['products'] != null) {
      products = new List<Products>();
      json['products'].forEach((v) {
        products.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['seq'] = this.seq;
    data['id'] = this.id;
    data['store_id'] = this.storeId;
    data['store_name'] = this.storeName;
    data['store_address'] = this.storeAddress;
    data['contact_person'] = this.contactPerson;
    data['note'] = this.note;
    data['created_by_name'] = this.createdByName;
    data['created_on'] = this.createdOn;
    data['is_export_stock'] = this.isExportStock;
    data['export_stock_id'] = this.exportStockId;
    data['export_stock_name'] = this.exportStockName;
    if (this.products != null) {
      data['products'] = this.products.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
  int id;
  String no;
  String name;
  Null unit;
  Null description;
  int price;
  bool isActive;
  int qty;
  Null imagePath;
  int total;

  Products(
      {this.id,
      this.no,
      this.name,
      this.unit,
      this.description,
      this.price,
      this.isActive,
      this.qty,
      this.imagePath,
      this.total});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    no = json['no'];
    name = json['name'];
    unit = json['unit'];
    description = json['description'];
    price = json['price'];
    isActive = json['is_active'];
    qty = json['qty'];
    imagePath = json['image_path'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['no'] = this.no;
    data['name'] = this.name;
    data['unit'] = this.unit;
    data['description'] = this.description;
    data['price'] = this.price;
    data['is_active'] = this.isActive;
    data['qty'] = this.qty;
    data['image_path'] = this.imagePath;
    data['total'] = this.total;
    return data;
  }
}
