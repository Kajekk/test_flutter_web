import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:test_flutter_web/constants/app_constants.dart';
import 'package:test_flutter_web/global_widgets/barrel.dart';
import '../data/models/account.dart';

class ItemDetail extends StatelessWidget {
  const ItemDetail({Key? key, required this.controller, required this.itemDetailInfo}) : super(key: key);
  final SubTabController controller;
  final Widget itemDetailInfo;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
          color: secondaryColor,
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Item Detail",
                style: Theme.of(context).textTheme.subtitle1,
              ),
              TextButton(
                // style: TextButton.styleFrom(
                //     padding: EdgeInsets.symmetric(
                //         horizontal: defaultPadding,
                //         vertical: defaultPadding / 1.8
                //     )),
                  style: TextButton.styleFrom(
                    primary: Colors.deepPurpleAccent,
                  ),
                  onPressed: () {},
                  child: Text("Edit")),
            ],
          ),
          SizedBox(
            height: defaultPadding,
          ),
          itemDetailInfo,
          // Column(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: controller.itemDetail!.toJson().entries.map((e) {
          //     // print(e.key);
          //     String value = e.value.toString();
          //     if (e.key == "created_time" || e.key == "last_updated_time") {
          //       var localTime = DateTime.parse(e.value).toLocal();
          //       value = DateFormat.yMd().add_jm().format(localTime);
          //     }
          //     return Padding(
          //       padding: const EdgeInsets.symmetric(vertical: 8),
          //       child: Text.rich(TextSpan(
          //           children: [
          //             TextSpan(text: e.key + ": \n", style: Theme.of(context).textTheme.subtitle1),
          //             TextSpan(text: value),
          //           ]
          //       )),
          //     );
          //   }).toList(),
          // ),
        ],
      ),
    );
  }
}
