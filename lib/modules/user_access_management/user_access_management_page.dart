import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:test_flutter_web/constants/app_constants.dart';
import 'package:test_flutter_web/data/barrel.dart';
import 'package:test_flutter_web/data/models/test.dart';
import 'package:test_flutter_web/global_widgets/barrel.dart';
import 'package:test_flutter_web/modules/user_access_management/barrel.dart';
import 'package:test_flutter_web/modules/user_access_management/states.dart';
import 'package:test_flutter_web/routes/app_pages.dart';
import 'package:get/get.dart';

class UserAccessManagementPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final EntityTypeController controller1 = Get.find();
  final EntityTypeController2 controller2 = Get.find();
  final EntityTypeController3 controller3 = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: SideMenu(),
      body: Container(
        // constraints: BoxConstraints(maxWidth: maxWidth),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (Responsive.isDesktop(context))
              Expanded(
                child: SideMenu(),
              ),
            Expanded(
                flex: 5,
                child: SafeArea(
                    child: SingleChildScrollView(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Column(
                    children: [
                      Header(
                        scaffoldKey: _scaffoldKey,
                        title: 'User Access Management',
                      ),
                      SizedBox(
                        height: defaultPadding,
                      ),
                      Category(
                        listController: [controller1, controller2, controller3],
                      ),
                      SizedBox(
                        height: defaultPadding,
                      ),
                      Obx(() {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                                flex: 5,
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    buildListItem([
                                      controller1,
                                      controller2,
                                      controller3
                                    ]),
                                    if (Responsive.isMobile(context))
                                      SizedBox(
                                        height: defaultPadding,
                                      ),
                                    if (Responsive.isMobile(context))
                                      ItemDetail(),
                                  ],
                                )),
                            if (!Responsive.isMobile(context))
                              SizedBox(
                                width: defaultPadding,
                              ),
                            if (!Responsive.isMobile(context))
                              Expanded(
                                flex: 2,
                                child: ItemDetail(),
                              )
                          ],
                        );
                      })
                    ],
                  ),
                )))
          ],
        ),
      ),
    );
  }

  Widget buildListItem(List<SubTabController> listController) {
    for (var controller in listController) {
      if (controller.isCurrent &&
          controller.categoryModel.title == CategoryListData.entityType.title) {
        return ListItem(
          controller: controller,
          dataTableSource: MyData(),
          isLoading: ((controller as EntityTypeController).emotionalLogState
                  is EmotionalLoading)
              ? true
              : false,
        );
      }
      if (controller.isCurrent &&
          controller.categoryModel.title ==
              CategoryListData.userPermissions.title) {
        return ListItem(controller: controller, dataTableSource: MyData());
      }
      if (controller.isCurrent &&
          controller.categoryModel.title == CategoryListData.userRoles.title) {
        return ListItem(controller: controller, dataTableSource: MyData());
      }
    }
    return CircularProgressIndicator();
  }
}

List<String> dataColumn = [
  "Organization",
  "Type",
  "Role",
  "Account Name",
];

class MyData extends DataTableSource {
  MyData({List<MyModel>? listData}) : _listData = listData;
  final List<MyModel>? _listData;

  final List<Map<String, dynamic>> testData = List.generate(
      5,
      (index) => {
            "id": index,
            "title": "Item $index",
            "price": Random().nextInt(10000),
            "4": "123213123",
          });

  bool get isRowCountApproximate => false;
  // int get rowCount => _listData.length;
  int get rowCount => testData.length;
  int get selectedRowCount => 0;

  DataRow? getRow(int index) {
    // if (index >= _listData.length) {
    //   return null;
    // }
    // final _data = _listData[index];
    //
    // return DataRow.byIndex(
    //   index: index,
    //   cells: [
    //     DataCell(Container(
    //         constraints: BoxConstraints(
    //           maxWidth: 200,
    //         ),
    //         child: Text('${_data.id}'))),
    //     DataCell(Container(
    //         constraints: BoxConstraints(
    //           maxWidth: 200,
    //         ),
    //         child: Text('${_data.title}'))),
    //     DataCell(Container(
    //         constraints: BoxConstraints(
    //           maxWidth: 200,
    //         ),
    //         child: Text('${_data.title}'))),
    //     DataCell(Container(
    //         constraints: BoxConstraints(
    //           maxWidth: 200,
    //         ),
    //         child: Text('${_data.title}'))),
    //   ],
    // );

    return DataRow.byIndex(
        index: index,
        cells: [
          DataCell(Text(testData[index]['id'].toString())),
          DataCell(Text(testData[index]["title"])),
          DataCell(Text(testData[index]["price"].toString())),
          DataCell(Text(testData[index]["4"])),
        ],
        onSelectChanged: (bool? selected) {
          if (selected!) {
            print('selected $index');
          }
        });
  }
}

class MyData2 extends DataTableSource {
  MyData2({required List<MyModel> listData}) : _listData = listData;
  final List<MyModel> _listData;

  final List<Map<String, dynamic>> testData = List.generate(
      5,
      (index) => {
            "id": index,
            "title": "Item $index",
            "price": Random().nextInt(10000),
            "4": "123213123",
          });

  bool get isRowCountApproximate => false;
  int get rowCount => _listData.length;
  // int get rowCount => testData.length;
  int get selectedRowCount => 0;

  DataRow? getRow(int index) {
    if (index >= _listData.length) {
      return null;
    }
    final _data = _listData[index];

    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text('${_data.id}')),
        DataCell(Text('${_data.title}')),
        DataCell(Text('${_data.title}')),
        DataCell(Text('${_data.title}')),
        DataCell(Text('${_data.title}')),
      ],
    );

    // return DataRow.byIndex(
    //     index: index,
    //     cells: [
    //       DataCell(Text(testData[index]['id'].toString())),
    //       DataCell(Text(testData[index]["title"])),
    //       DataCell(Text(testData[index]["price"].toString())),
    //       DataCell(Text(testData[index]["4"])),
    //       DataCell(Text(testData[index]["4"])),
    //     ],
    //     onSelectChanged: (bool? selected) {
    //       if (selected!) {
    //         print('selected $index');
    //       }
    //     });
  }
}

class MyData3 extends DataTableSource {
  MyData3({required List<MyModel> listData}) : _listData = listData;
  final List<MyModel> _listData;

  final List<Map<String, dynamic>> testData = List.generate(
      5,
      (index) => {
            "id": index,
            "title": "Item $index",
            "price": Random().nextInt(10000),
            "4": "123213123",
          });

  bool get isRowCountApproximate => false;
  int get rowCount => _listData.length;
  // int get rowCount => testData.length;
  int get selectedRowCount => 0;

  DataRow? getRow(int index) {
    if (index >= _listData.length) {
      return null;
    }
    final _data = _listData[index];

    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text('${_data.id}')),
        DataCell(Text('${_data.title}')),
        DataCell(Text('${_data.title}')),
        DataCell(Text('${_data.title}')),
        DataCell(Text('${_data.title}')),
        DataCell(Text('${_data.title}')),
      ],
    );

    // return DataRow.byIndex(
    //     index: index,
    //     cells: [
    //       DataCell(Text(testData[index]['id'].toString())),
    //       DataCell(Text(testData[index]["title"])),
    //       DataCell(Text(testData[index]["price"].toString())),
    //       DataCell(Text(testData[index]["4"])),
    //       DataCell(Text(testData[index]["price"].toString())),
    //       DataCell(Text(testData[index]["price"].toString())),
    //     ],
    //     onSelectChanged: (bool? selected) {
    //       if (selected!) {
    //         print('selected $index');
    //       }
    //     });
  }
}

//
// class Category extends StatelessWidget {
//   // final List<CategoryCardModel> subPageList;
//   // final UserAccessManagementController controller;
//   // final String tag;
//   const Category({Key? key
//     // required this.controller}
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     // final CategoryController categoryController = Get.find(tag: tag);
//     final Size _size = MediaQuery.of(context).size;
//     return Column(
//       children: [
//         Responsive(
//             mobile: CategoryCard(
//               crossAxisCount: _size.width < 650 ? 2 : 4,
//               childAspectRatio: _size.width < 650 ? 10/5 : 10/9,
//               // listData: subPageList,
//
//             ),
//             tablet: CategoryCard(),
//             desktop: CategoryCard(
//               childAspectRatio: _size.width < 1400 ? 10/7 : 10/6,
//               // listData: subPageList,
//
//             ))
//       ],
//     );
//   }
// }
//
// class CategoryCard extends StatelessWidget {
//   const CategoryCard({
//     Key? key,
//     this.crossAxisCount = 5,
//     this.childAspectRatio = 10/8,
//     // required this.listData,
//   }) : super(key: key);
//
//   final int crossAxisCount;
//   final double childAspectRatio;
//   // final List<CategoryCardModel> listData;
//   // final String tag;
//
//   @override
//   Widget build(BuildContext context) {
//     // CategoryController categoryController = Get.find(tag: tag);
//     UserAccessManagementController controller = Get.find();
//
//     return GridView.builder(
//         physics: NeverScrollableScrollPhysics(),
//         shrinkWrap: true,
//         itemCount: controller.categoryList.length,
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: crossAxisCount,
//           crossAxisSpacing: defaultPadding,
//           mainAxisSpacing: defaultPadding,
//           childAspectRatio: childAspectRatio,
//         ),
//         itemBuilder: (context, index) => CategoryInfoCard(
//           category: controller.categoryList[index],
//           // info: categoryController.mapCategoryCard.values.elementAt(index),
//         ));
//   }
// }
//
// class CategoryInfoCard extends StatelessWidget {
//   const CategoryInfoCard({
//     Key? key,
//     required this.category
//   }) : super(key: key);
//
//   // final Map<String, dynamic> info;
//   // final String tag;
//   final CategoryCardModel category;
//   @override
//   Widget build(BuildContext context) {
//     final UserAccessManagementController controller = Get.find();
//     return InkWell(
//       onTap: () {
//         // Get.toNamed(info.route!, arguments: {
//         //   'id': '123'
//         // });
//         // categoryController.changeCategory(info["title"]!);
//         controller.changeCurrentCategory(category.title);
//       },
//       child: Container(
//         padding: EdgeInsets.only(left: defaultPadding, right: defaultPadding, top: defaultPadding / 2),
//         decoration: BoxDecoration(
//             color: secondaryColor,
//             borderRadius: const BorderRadius.all(Radius.circular(10))),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             SvgPicture.asset(
//               // info["svgSource"]!,
//               category.svgSource!,
//               color: Colors.white54,
//               height: 24,
//             ),
//             AutoSizeText(
//               // info["title"],
//               category.title,
//               maxLines: 2,
//               overflow: TextOverflow.ellipsis,
//               style: Theme.of(context).textTheme.subtitle2,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
