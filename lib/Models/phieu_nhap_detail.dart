class PhieuNhapDetail {
  int productId;
  int qty;
  String stockId;
  String productNo;
  String productName;
  int productPrice;

  PhieuNhapDetail(
      {this.productId,
      this.qty,
      this.stockId,
      this.productNo,
      this.productName,
      this.productPrice});

  PhieuNhapDetail.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    qty = json['qty'];
    stockId = json['stock_id'];
    productNo = json['product_no'];
    productName = json['product_name'];
    productPrice = json['product_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['qty'] = this.qty;
    data['stock_id'] = this.stockId;
    data['product_no'] = this.productNo;
    data['product_name'] = this.productName;
    data['product_price'] = this.productPrice;
    return data;
  }
}
