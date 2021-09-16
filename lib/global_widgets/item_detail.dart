import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:test_flutter_web/constants/app_constants.dart';
import 'package:test_flutter_web/global_widgets/barrel.dart';
import '../data/models/account.dart';

class ItemDetail extends StatelessWidget {
  const ItemDetail({Key? key, required this.itemDetailInfo, this.customDialog}) : super(key: key);
  // final SubTabController controller;
  final Widget itemDetailInfo;
  final Widget? customDialog;

  @override
  Widget build(BuildContext context) {

    void onEditButtonPressed() {
      if (customDialog != null)
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return customDialog!;
            });
    }


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
                  style: TextButton.styleFrom(
                    primary: Colors.deepPurpleAccent,
                  ),
                  onPressed: onEditButtonPressed,
                  child: Text("Edit")),
            ],
          ),
          SizedBox(
            height: defaultPadding,
          ),
          itemDetailInfo,
        ],
      ),
    );
  }
}
