class PhieuNhap {
  String stockId;
  String seq;

  PhieuNhap({this.stockId, this.seq});

  PhieuNhap.fromJson(Map<String, dynamic> json) {
    stockId = json['stock_id'];
    seq = json['seq'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['stock_id'] = this.stockId;
    data['seq'] = this.seq;
    return data;
  }
}
