abstract class DrawModule {
  static const INVENTORY_TRANSACTIONS = 'Tồn kho';
  static const INVENTORY_PURCHASE_ORDERS = 'Mua hàng';
  static const INVENTORY_TRANSFERS = 'Điều chuyển';
  static const INVENTORY_ADJUSTMENTS = 'Điều chỉnh';
}

abstract class DrawFunction {
  static const INDEX = 'index';
  static const NEW = 'new';
  static const IMPORT = 'import';
}
