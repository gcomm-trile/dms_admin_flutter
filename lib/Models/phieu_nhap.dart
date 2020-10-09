class PhieuNhap {
  String id;
  String importStockId;
  String importStockName;
  String exportStockId;
  String exportStockName;
  int seq;
  String seqNo;
  String createdByFullname;
  String createdOn;
  String approvedByFullname;
  String approvedOn;
  int status;
  String statusName;

  PhieuNhap(
      {this.id,
      this.importStockId,
      this.importStockName,
      this.exportStockId,
      this.exportStockName,
      this.seq,
      this.seqNo,
      this.createdByFullname,
      this.createdOn,
      this.approvedByFullname,
      this.approvedOn,
      this.status,
      this.statusName});

  PhieuNhap.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    importStockId = json['import_stock_id'];
    importStockName = json['import_stock_name'];
    exportStockId = json['export_stock_id'];
    exportStockName = json['export_stock_name'];
    seq = json['seq'];
    seqNo = json['seq_no'];
    createdByFullname = json['created_by_fullname'];
    createdOn = json['created_on'];
    approvedByFullname = json['approved_by_fullname'];
    approvedOn = json['approved_on'];
    status = json['status'];
    statusName = json['status_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['import_stock_id'] = this.importStockId;
    data['import_stock_name'] = this.importStockName;
    data['export_stock_id'] = this.exportStockId;
    data['export_stock_name'] = this.exportStockName;
    data['seq'] = this.seq;
    data['seq_no'] = this.seqNo;
    data['created_by_fullname'] = this.createdByFullname;
    data['created_on'] = this.createdOn;
    data['approved_by_fullname'] = this.approvedByFullname;
    data['approved_on'] = this.approvedOn;
    data['status'] = this.status;
    data['status_name'] = this.statusName;
    return data;
  }
}
