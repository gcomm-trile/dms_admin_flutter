class Inventory {
  String stockId;
  String stockName;
  int productId;
  int currentQty;
  String productNo;
  String productName;
  String productUnit;
  String productDescription;
  int productPrice;
  bool productIsActive;
  String productImagePath;

  Inventory(
      {this.stockId,
      this.stockName,
      this.productId,
      this.currentQty,
      this.productNo,
      this.productName,
      this.productUnit,
      this.productDescription,
      this.productPrice,
      this.productIsActive,
      this.productImagePath});

  Inventory.fromJson(Map<String, dynamic> json) {
    stockId = json['stock_id'];
    stockName = json['stock_name'];
    productId = json['product_id'];
    currentQty = json['current_qty'];
    productNo = json['product_no'];
    productName = json['product_name'];
    productUnit = json['product_unit'];
    productDescription = json['product_description'];
    productPrice = json['product_price'];
    productIsActive = json['product_is_active'];
    productImagePath = json['product_image_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['stock_id'] = this.stockId;
    data['stock_name'] = this.stockName;
    data['product_id'] = this.productId;
    data['current_qty'] = this.currentQty;
    data['product_no'] = this.productNo;
    data['product_name'] = this.productName;
    data['product_unit'] = this.productUnit;
    data['product_description'] = this.productDescription;
    data['product_price'] = this.productPrice;
    data['product_is_active'] = this.productIsActive;
    data['product_image_path'] = this.productImagePath;
    return data;
  }
}
