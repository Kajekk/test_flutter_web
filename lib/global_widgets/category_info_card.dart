import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:test_flutter_web/constants/app_constants.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:test_flutter_web/global_widgets/barrel.dart';
import 'package:test_flutter_web/routes/app_pages.dart';

class CategoryInfoCard extends StatelessWidget {
  const CategoryInfoCard({
    Key? key,
    required this.controller
  }) : super(key: key);

  final SubTabController controller;

  @override
  Widget build(BuildContext context) {

    // final CategoryController categoryController = Get.find(tag: tag);
    return InkWell(
      onTap: () {
        controller.changeSubTab();
      },
      child: Container(
        padding: EdgeInsets.only(left: defaultPadding, right: defaultPadding, top: defaultPadding / 2),
        decoration: BoxDecoration(
            color: secondaryColor,
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // SvgPicture.asset(
            //   controller.subTabInfoModel.svgSource!,
            //   color: Colors.white54,
            //   height: 24,
            // ),
            Text(
              controller.subTabInfoModel.title!,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ],
        ),
      ),
    );
  }
}

