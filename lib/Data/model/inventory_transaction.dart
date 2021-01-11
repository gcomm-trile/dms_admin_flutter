class InventoryTransaction {
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

  InventoryTransaction(
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

  InventoryTransaction.fromJson(Map<String, dynamic> json) {
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
}
