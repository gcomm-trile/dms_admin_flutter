class InventoryPurchaseOrder {
  String purchaseOrderId;

  InventoryPurchaseOrder({
    this.purchaseOrderId,
  });

  InventoryPurchaseOrder.fromJson(Map<String, dynamic> json) {
    purchaseOrderId = json['purchase_order_id'];
  }
}
