class MoneyFormat {
  String price;

  static int moneyFormat(String price) {
    if (price == null || price.isEmpty) return 0;
    price = price.replaceAll(',', '');
    print(price);
    return int.parse(price);
  }
}
