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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['no'] = this.no;
    data['name'] = this.name;
    data['is_active'] = this.isActive;
    return data;
  }
}
