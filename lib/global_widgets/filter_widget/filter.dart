import 'package:dms_admin/Helper/UI.dart';
import 'package:dms_admin/data/model/filter.dart';
import 'package:dms_admin/data/model/filter_expression.dart';
import 'package:dms_admin/data/model/product.dart';
import 'package:dms_admin/data/model/stock.dart';
import 'package:dms_admin/data/repository/filters_repository.dart';
import 'package:dms_admin/global_widgets/filter_dialog/filter_dialog.dart';
import 'package:dms_admin/utils/text_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_guid/flutter_guid.dart';
import 'package:get/get.dart';

class FilterWidget extends StatefulWidget {
  final String module;
  final List<Product> products;
  final List<Stock> stocks;

  final Function(List<FilterExpression> filterExpressions) onValueChanged;
  FilterWidget({
    Key key,
    @required this.module,
    @required this.products,
    @required this.stocks,
    this.onValueChanged,
  }) : super(key: key);

  @override
  _FilterWidgetState createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  List<FilterExpression> filterExpressions = List<FilterExpression>();
  final FiltersRepository filtersRepository = Get.find();
  List<Filter> filters = List<Filter>();
  Future<List<Filter>> inventory;
  @override
  void initState() {
    super.initState();
    filters.add(Filter(
        id: TextHelper.getDefaultGuidString(),
        name: 'Tất cả',
        isSelected: true,
        filterExpressions: List<FilterExpression>()));
    inventory = filtersRepository.getId(widget.module);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Filter>>(
      future: inventory,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          for (var item in snapshot.data) {
            filters.add(item);
          }
          return Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(5.0)),
            child: Column(
              children: [
                Container(
                  height: 25,
                  child: ListView.separated(
                    separatorBuilder: (context, index) => SizedBox(
                      width: 10.0,
                    ),
                    //shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: filters.length,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                        child: InkWell(
                          onTap: () => selectedFilter(filters[index], index),
                          child: filters[index].isSelected == true
                              ? Column(
                                  children: [
                                    Text(
                                      filters[index].name,
                                      style: TextStyle(
                                          color: Colors.blue[900],
                                          decoration: TextDecoration.underline,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                  ],
                                )
                              : Text(
                                  filters[index].name,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                  ),
                                ),
                        ),
                      );
                    },
                  ),
                ),
                Divider(
                  thickness: 2,
                ),
                Row(
                  children: [
                    RaisedButton(
                        color: Colors.white,
                        child: Row(
                          children: [
                            Icon(Icons.filter_alt),
                            Text('Thêm điều kiện lọc'),
                          ],
                        ),
                        onPressed: () {
                          showFilterDialog();
                        }),
                    SizedBox(
                      width: 10,
                    ),
                    filterExpressions.length > 0
                        ? RaisedButton(
                            child: Row(
                              children: [
                                Icon(Icons.save_rounded),
                                Text('Lưu bộ lọc'),
                              ],
                            ),
                            onPressed: () {
                              saveFilter(context);
                            },
                          )
                        : SizedBox(
                            width: 1,
                          ),
                  ],
                ),
                Container(
                  height: 20,
                  child: ListView.separated(
                    separatorBuilder: (context, index) => Divider(
                      thickness: 0.5,
                    ),
                    //shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: filterExpressions.length,
                    itemBuilder: (context, index) {
                      return Container(
                        // margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
                        padding: EdgeInsets.only(left: 10, right: 10),
                        decoration: BoxDecoration(
                          color: Colors.grey[350],
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(children: [
                          Text(
                            filterExpressions[index].getDisplayName(),
                            style: TextStyle(
                              fontSize: 11,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              filterExpressionRemove(index);
                            },
                            child: Icon(
                              Icons.close,
                              size: 17,
                            ),
                          ),
                        ]),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 7,
                ),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text("${snapshot.error}"));
        }
        return CircularProgressIndicator();
      },
    );
  }

  void showFilterDialog() {
    Get.dialog(
      AlertDialog(
        content: FilterDialog(
          products: widget.products,
          stocks: widget.stocks,
          savedData: (filterExpression) {
            filterExpressions.add(filterExpression);
            updateDataByFilterChange();
            print('Ok');
          },
        ),
      ),
    );
  }

  void filterExpressionRemove(int index) {
    setState(() {
      filterExpressions.removeAt(index);
      updateDataByFilterChange();
    });
  }

  selectedFilter(Filter filter, int index) {
    for (int i = 0; i < filters.length; i++) {
      setFilter(i, index == i ? true : false);
    }

    var _filterExpressions = List<FilterExpression>();
    for (var filterExpression in filters[index].filterExpressions) {
      _filterExpressions.add(filterExpression);
    }
    filterExpressions = _filterExpressions;
    setState(() {
      updateDataByFilterChange();
    });
  }

  void updateDataByFilterChange() {
    this.widget.onValueChanged(this.filterExpressions);
    print('data changed');
  }

  void setFilter(int i, bool value) {
    var item = filters[i];
    item.isSelected = value;
    filters[i] = item;
  }

  void saveFilter(BuildContext context) {
    var item = filters.where((e) => e.isSelected == true).first;
    String id;
    String name;
    if (item.id == TextHelper.getDefaultGuidString()) {
      var textEditController = TextEditingController();
      Get.dialog(
        AlertDialog(
          title: Text('Tên bộ lọc'),
          content: TextField(
            controller: textEditController,
          ),
          actions: [
            ElevatedButton(
                onPressed: () {
                  if (textEditController.text.isNotEmpty) {
                    id = Guid.newGuid.value.toString();
                    name = textEditController.text.toUpperCase();
                    print(id);
                    print(name);
                    filtersRepository
                        .add(widget.module, id, name, filterExpressions)
                        .then((data) {
                      filters.clear();
                      filters.add(Filter(
                          id: TextHelper.getDefaultGuidString(),
                          name: 'Tất cả',
                          isSelected: false,
                          filterExpressions: List<FilterExpression>()));
                      for (var item in data) {
                        if (item.id == id) {
                          item.isSelected = true;
                        }
                        filters.add(item);
                      }
                      setState(() {
                        updateDataByFilterChange();
                      });
                      print('success');
                      Navigator.of(context).pop();
                      UI.showSuccess('Đã cập nhật thành công');
                    }).catchError((e) {
                      print(e.toString());
                      Get.snackbar('Error', e.toString());
                    });
                  }
                },
                child: Text('Lưu bộ lọc')),
          ],
        ),
      );
    } else {
      id = item.id;
      name = item.name;

      filtersRepository
          .add(widget.module, id, name, filterExpressions)
          .then((data) {
        print('success');
        UI.showSuccess('Đã cập nhật thành công');
      }).catchError((e) {
        print(e.toString());
        Get.snackbar('Error', e.toString());
      });
    }
  }
}
