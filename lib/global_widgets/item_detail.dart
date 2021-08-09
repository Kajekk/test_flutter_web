import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_flutter_web/constants/app_constants.dart';
import 'package:test_flutter_web/models/account.dart';

class ItemDetail extends StatelessWidget {
  const ItemDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
          color: secondaryColor,
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: Column(
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
          Text(
            "Select 1 item to view detail",
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ],
      ),
    );
  }
}

var mockData = Account(
    type: "qweqw", role: "123", organization: "qweqwe", accountName: "qweqwe");
