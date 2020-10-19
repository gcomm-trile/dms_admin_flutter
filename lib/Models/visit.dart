class Visit {
  String id;
  String storeId;
  bool isOpened;
  String feedBack;
  String createdOn;
  String seq;
  String storeName;
  String userName;

  Visit({
    this.id,
    this.storeId,
    this.isOpened,
    this.feedBack,
    this.createdOn,
    this.seq,
    this.storeName,
    this.userName,
  });

  Visit.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    storeId = json['store_id'];
    isOpened = json['is_opened'];
    feedBack = json['feed_back'];

    createdOn = json['createdOn'];
    seq = json['seq'];
    storeName = json['store_name'];
    userName = json['user_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['store_id'] = this.storeId;
    data['is_opened'] = this.isOpened;
    data['feed_back'] = this.feedBack;

    data['createdOn'] = this.createdOn;
    data['seq'] = this.seq;
    data['store_name'] = this.storeName;
    data['user_name'] = this.userName;

    return data;
  }
}
