class PhieuXuat {
  String id;
  String seq;
  String exportStockId;
  String importStockId;
  String importStockName;
  String createdBy;
  String approvedBy;
  String createdOn;
  String approvedOn;
  String status;

  PhieuXuat(
      {this.id,
      this.seq,
      this.exportStockId,
      this.importStockId,
      this.importStockName,
      this.createdBy,
      this.approvedBy,
      this.createdOn,
      this.approvedOn,
      this.status});

  PhieuXuat.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    seq = json['seq'];
    exportStockId = json['export_stock_id'];
    importStockId = json['import_stock_id'];
    importStockName = json['import_stock_name'];
    createdBy = json['created_by'];
    approvedBy = json['approved_by'];
    createdOn = json['created_on'];
    approvedOn = json['approved_on'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['seq'] = this.seq;
    data['export_stock_id'] = this.exportStockId;
    data['import_stock_id'] = this.importStockId;
    data['import_stock_name'] = this.importStockName;
    data['created_by'] = this.createdBy;
    data['approved_by'] = this.approvedBy;
    data['created_on'] = this.createdOn;
    data['approved_on'] = this.approvedOn;
    data['status'] = this.status;
    return data;
  }
}
