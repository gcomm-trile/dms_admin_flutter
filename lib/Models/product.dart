class Product {
  int id;
  String no;
  String name;
  String unit;
  String description;
  int price;
  bool isActive;
  int qty;
  int total;
  String image_path;

  Product(
      {this.id,
      this.no,
      this.name,
      this.unit,
      this.description,
      this.price,
      this.isActive,
      this.qty,
      this.total,
      this.image_path});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    no = json['no'];
    name = json['name'];
    unit = json['unit'];
    description = json['description'];
    price = json['price'];
    isActive = json['is_active'];
    qty = json['qty'];
    total = json['total'];
    image_path = json['image_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['no'] = this.no;
    data['name'] = this.name;
    data['unit'] = this.unit;
    data['description'] = this.description;
    data['price'] = this.price;
    data['is_active'] = this.isActive;
    data['qty'] = this.qty;
    data['total'] = this.total;
    data['image_path'] = this.image_path;
    return data;
  }
}
