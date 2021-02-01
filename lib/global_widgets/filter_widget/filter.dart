import 'package:dms_admin/Helper/UI.dart';
import 'package:dms_admin/data/model/filter.dart';
import 'package:dms_admin/data/model/filter_expression.dart';
import 'package:dms_admin/data/repository/filters_repository.dart';
import 'package:dms_admin/global_widgets/filter_dialog/filter_dialog.dart';
import 'package:dms_admin/utils/text_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_guid/flutter_guid.dart';
import 'package:get/get.dart';

class FilterDataChange {
  List<FilterExpression> filterExpressions = List<FilterExpression>();
  String searchText = '';
  FilterDataChange({this.filterExpressions, this.searchText});
}

class FilterWidget extends StatefulWidget {
  final String module;

  final Function(FilterDataChange data) filterDataChange;
  FilterWidget({
    Key key,
    @required this.module,
    this.filterDataChange,
  }) : super(key: key);

  @override
  _FilterWidgetState createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  FilterDataChange filterData = FilterDataChange();
  List<FilterExpression> filterExpressions = List<FilterExpression>();
  final FiltersRepository filtersRepository = Get.find();
  int selectedIndex = 0;
  List<Filter> filters = List<Filter>();
  Future<List<Filter>> inventory;
  TextEditingController searchTextController;
  @override
  void initState() {
    super.initState();
    searchTextController = TextEditingController();
    inventory = filtersRepository.getId(widget.module);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Filter>>(
      future: inventory,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (filters.length == 0) {
            filters.clear();
            filters.add(Filter(
                id: TextHelper.getDefaultGuidString(),
                name: 'Tất cả',
                filterExpressions: List<FilterExpression>()));
            for (var item in snapshot.data) {
              filters.add(item);
            }
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
                          child: selectedIndex == index
                              // filters[index].isSelected == true
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
                Container(
                  height: 40,
                  child: Row(
                    children: [
                      RaisedButton(
                          color: Colors.white,
                          child: Row(
                            children: [
                              Icon(Icons.filter_alt),
                              Text('Thêm ĐK'),
                            ],
                          ),
                          onPressed: () {
                            showFilterDialog();
                          }),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: TextField(
                          controller: searchTextController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: 15.0),
                            border: OutlineInputBorder(),
                            hintText: "Tìm kiếm",
                            prefixIcon: Icon(Icons.search),
                            suffixIcon: null,
                          ),
                          onChanged: (value) {
                            updateDataByFilterChange();
                          },
                        ),
                      ),
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
                                var item = filters[selectedIndex];
                                String id = '';
                                String name;
                                if (item.id ==
                                    TextHelper.getDefaultGuidString()) {
                                  id = Guid.newGuid.value.toString();
                                  var textEditController =
                                      TextEditingController();
                                  Get.dialog(
                                    AlertDialog(
                                      title: Text('Tên bộ lọc'),
                                      content: TextField(
                                        controller: textEditController,
                                      ),
                                      actions: [
                                        ElevatedButton(
                                            onPressed: () {
                                              if (textEditController
                                                  .text.isNotEmpty) {
                                                id = Guid.newGuid.value
                                                    .toString();
                                                name = textEditController.text
                                                    .toUpperCase();

                                                filtersRepository
                                                    .add(widget.module, id,
                                                        name, filterExpressions)
                                                    .then((data) {
                                                  setState(() {
                                                    var _filters = <Filter>[];
                                                    _filters.add(Filter(
                                                        id: TextHelper
                                                            .getDefaultGuidString(),
                                                        name: 'Tất cả',
                                                        filterExpressions: List<
                                                            FilterExpression>()));
                                                    for (int i = 0;
                                                        i < data.length;
                                                        i++) {
                                                      // if (item.id == id) {
                                                      //   selectedIndex = i + 1;
                                                      // }
                                                      _filters.add(data[i]);
                                                    }

                                                    Navigator.of(context)
                                                        .pop(_filters);
                                                    UI.showSuccess(
                                                        'Đã cập nhật thành công');
                                                  });
                                                }).catchError((e) {
                                                  Get.snackbar(
                                                      'Error', e.toString());
                                                });
                                              }
                                            },
                                            child: Text('Lưu bộ lọc')),
                                      ],
                                    ),
                                  ).then((value) {
                                    setState(() {
                                      filters = value;
                                      for (int i = 0; i < filters.length; i++) {
                                        if (filters[i].id == id) {
                                          selectedIndex = i;
                                        }
                                      }
                                      updateDataByFilterChange();
                                    });
                                  });
                                } else {
                                  id = item.id;
                                  name = item.name;

                                  filtersRepository
                                      .add(widget.module, id, name,
                                          filterExpressions)
                                      .then((data) {
                                    filters.clear();
                                    filters.add(Filter(
                                        id: TextHelper.getDefaultGuidString(),
                                        name: 'Tất cả',
                                        filterExpressions:
                                            List<FilterExpression>()));
                                    for (int i = 0; i < data.length; i++) {
                                      // if (item.id == id) {
                                      //   selectedIndex = i + 1;
                                      // }
                                      filters.add(data[i]);
                                    }
                                    UI.showSuccess('Đã cập nhật thành công');
                                  }).catchError((e) {
                                    Get.snackbar('Error', e.toString());
                                  });
                                }
                              },
                            )
                          : SizedBox(
                              width: 1,
                            ),
                    ],
                  ),
                ),
                Container(
                  height: 20,
                  child: ListView.separated(
                    separatorBuilder: (context, index) => SizedBox(
                      width: 3,
                    ),
                    //shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: filterExpressions.length,
                    itemBuilder: (context, index) {
                      return Container(
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
                          SizedBox(
                            width: 5,
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
          module: widget.module,
          savedData: (filterExpression) {
            filterExpressions.add(filterExpression);

            updateDataByFilterChange();
            setState(() {});
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
    setState(() {
      selectedIndex = index;
      for (int i = 0; i < filters.length; i++) {
        setFilter(i, index == i ? true : false);
      }

      var _filterExpressions = List<FilterExpression>();
      for (var filterExpression in filters[index].filterExpressions) {
        _filterExpressions.add(filterExpression);
      }
      filterExpressions = _filterExpressions;
      updateDataByFilterChange();
    });
  }

  void updateDataByFilterChange() {
    this.widget.filterDataChange(FilterDataChange(
        searchText: searchTextController.text,
        filterExpressions: filterExpressions));
  }

  void setFilter(int i, bool value) {
    var item = filters[i];
    // item.isSelected = value;
    filters[i] = item;
  }
}
