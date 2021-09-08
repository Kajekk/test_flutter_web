import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_flutter_web/constants/app_constants.dart';
import 'package:test_flutter_web/global_widgets/responsive.dart';
import 'category_info_card.dart';
import 'controllers/barrel.dart';

class Category extends StatelessWidget {
  // final List<CategoryCardModel> subPageList;
  final List<SubTabController> listController;
  // final String tag;
  const Category({Key? key,
    required this.listController
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final CategoryController categoryController = Get.find(tag: tag);
    final Size _size = MediaQuery.of(context).size;
    return Column(
      children: [
        Responsive(
            mobile: CategoryCard(
              crossAxisCount: _size.width < 650 ? 2 : 4,
              childAspectRatio: _size.width < 650 ? 10/5 : 10/9,
                listController: listController,
              // listData: subPageList,
            ),
            tablet: CategoryCard(listController: listController,),
            desktop: CategoryCard(
              childAspectRatio: _size.width < 1400 ? 10/7 : 10/6,
              listController: listController,
              // listData: subPageList,
            ))
      ],
    );
  }
}

// class MyInherited extends InheritedWidget {
//
//   static MyInherited of(BuildContext context) {
//     return context.dependOnInheritedWidgetOfExactType<MyInherited>();
//   }
//
//   @override
//   bool updateShouldNotify(covariant InheritedWidget oldWidget) {
//     // TODO: implement updateShouldNotify
//     throw UnimplementedError();
//   }
//
// }

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
    this.crossAxisCount = 5,
    this.childAspectRatio = 10/8,
    required this.listController,
  }) : super(key: key);

  final List<SubTabController> listController;
  final int crossAxisCount;
  final double childAspectRatio;
  // final List<CategoryCardModel> listData;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: listController.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: defaultPadding,
          mainAxisSpacing: defaultPadding,
          childAspectRatio: childAspectRatio,
        ),
        itemBuilder: (context, index) => CategoryInfoCard(
              // info: listData[index],
              controller: listController[index],
            ));
  }
}

// List mockData = [
//   CategoryCardModel(
//       title: "Account", svgSource: "assets/icons/menu_dashboard.svg"),
//   CategoryCardModel(
//       title: "Account Relationship Relationship",
//       svgSource: "assets/icons/menu_dashboard.svg"),
//   // CategoryCardModel(
//   //     title: "Example", svgSource: "assets/icons/menu_dashboard.svg"),
//   // CategoryCardModel(
//   //     title: "Account", svgSource: "assets/icons/menu_dashboard.svg"),
//   // CategoryCardModel(
//   //     title: "Account", svgSource: "assets/icons/menu_dashboard.svg"),
// ];
