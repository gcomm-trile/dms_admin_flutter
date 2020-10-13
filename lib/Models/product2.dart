import 'package:get/state_manager.dart';

class Product2 {
  final int id;
  final String productName;
  final String productImage;
  final String productDescription;
  final double price;

  Product2({
    this.id,
    this.productName,
    this.productImage,
    this.productDescription,
    this.price,
  });

  final isFavorite = false.obs;
}
