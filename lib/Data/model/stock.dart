class Stock {
  String id;
  String no;
  String name;
  bool isActive;

  Stock({this.id, this.no, this.name, this.isActive});

  Stock.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    no = json['no'];
    name = json['name'];
    isActive = json['is_active'];
  }
}
