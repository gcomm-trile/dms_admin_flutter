class DashboardActivity {
  String updatedOn;
  String storeId;
  String storeName;
  String userFullname;
  String province;
  String userId;
  int actionType;
  String content;
  String visitId;

  DashboardActivity(
      {this.updatedOn,
      this.storeId,
      this.storeName,
      this.userFullname,
      this.province,
      this.userId,
      this.actionType,
      this.content,
      this.visitId});

  DashboardActivity.fromJson(Map<String, dynamic> json) {
    updatedOn = json['updated_on'];
    storeId = json['store_id'];
    storeName = json['store_name'];
    userFullname = json['user_fullname'];
    province = json['province'];
    userId = json['user_id'];
    actionType = json['action_type'];
    content = json['content'];
    visitId = json['visit_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['updated_on'] = this.updatedOn;
    data['store_id'] = this.storeId;
    data['store_name'] = this.storeName;
    data['user_fullname'] = this.userFullname;
    data['province'] = this.province;
    data['user_id'] = this.userId;
    data['action_type'] = this.actionType;
    data['content'] = this.content;
    data['visit_id'] = this.visitId;
    return data;
  }
}
