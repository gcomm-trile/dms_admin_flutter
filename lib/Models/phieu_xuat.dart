class PhieuXuat {
  String id;
  int seq;
  String seqNo;
  String importStockId;
  String importStockName;
  String exportStockId;
  String createdOn;
  String createdBy;
  String createdByName;
  String approvedOn;
  String approvedByName;
  String approvedBy;
  int status;
  String statusName;
  int type;

  PhieuXuat(
      {this.id,
      this.seq,
      this.seqNo,
      this.importStockId,
      this.importStockName,
      this.exportStockId,
      this.createdOn,
      this.createdBy,
      this.createdByName,
      this.approvedOn,
      this.approvedByName,
      this.approvedBy,
      this.status,
      this.statusName,
      this.type});

  PhieuXuat.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    seq = json['seq'];
    seqNo = json['seq_no'];
    importStockId = json['import_stock_id'];
    importStockName = json['import_stock_name'];
    exportStockId = json['export_stock_id'];
    createdOn = json['created_on'];
    createdBy = json['created_by'];
    createdByName = json['created_by_name'];
    approvedOn = json['approved_on'];
    approvedByName = json['approved_by_name'];
    approvedBy = json['approved_by'];
    status = json['status'];
    statusName = json['status_name'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['seq'] = this.seq;
    data['seq_no'] = this.seqNo;
    data['import_stock_id'] = this.importStockId;
    data['import_stock_name'] = this.importStockName;
    data['export_stock_id'] = this.exportStockId;
    data['created_on'] = this.createdOn;
    data['created_by'] = this.createdBy;
    data['created_by_name'] = this.createdByName;
    data['approved_on'] = this.approvedOn;
    data['approved_by_name'] = this.approvedByName;
    data['approved_by'] = this.approvedBy;
    data['status'] = this.status;
    data['status_name'] = this.statusName;
    data['type'] = this.type;
    return data;
  }
}
