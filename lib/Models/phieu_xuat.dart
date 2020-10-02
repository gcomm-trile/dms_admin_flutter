class PhieuXuat {
  String id;
  String status;
  String stockId;
  String seq;
  String createdBy;
  String approvedBy;
  String createdOn;
  String approvedOn;

  PhieuXuat(
      {this.id,
      this.stockId,
      this.seq,
      this.createdBy,
      this.approvedBy,
      this.createdOn,
      this.approvedOn,
      this.status});

  PhieuXuat.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    stockId = json['stock_id'];
    seq = json['seq'];
    createdBy = json['created_by'];
    approvedBy = json['approved_by'];
    createdOn = json['created_on'];
    approvedOn = json['approved_on'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['stock_id'] = this.stockId;
    data['seq'] = this.seq;
    data['created_by'] = this.createdBy;
    data['approved_by'] = this.approvedBy;
    data['created_on'] = this.createdOn;
    data['approved_on'] = this.approvedOn;
    data['status'] = this.status;
    return data;
  }
}
