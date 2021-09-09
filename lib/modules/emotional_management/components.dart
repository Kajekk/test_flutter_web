import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:test_flutter_web/constants/barrel.dart';
import 'package:test_flutter_web/data/models/barrel.dart';

import 'barrel.dart';

class EmotionalLogItemDetailInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    EmotionalLogController controller = Get.find();
    return Obx(() {
      if (controller.itemDetail == null) {
        return Center(
          child: Text(
            "Select 1 row to view detail",
            style: Theme.of(context).textTheme.bodyText2,
          ),
        );
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(TextSpan(
              children: [
                TextSpan(text: "Uid: \n", style: Theme.of(context).textTheme.subtitle1),
                TextSpan(text: controller.itemDetail!.uid),
              ]
          )),
          SizedBox(height: defaultPadding/2,),
          Text.rich(TextSpan(
              children: [
                TextSpan(text: "Email: \n", style: Theme.of(context).textTheme.subtitle1),
                TextSpan(text: controller.itemDetail!.email),
              ]
          )),
          SizedBox(height: defaultPadding/2,),
          Text.rich(TextSpan(
              children: [
                TextSpan(text: "Type: \n", style: Theme.of(context).textTheme.subtitle1),
                TextSpan(text: controller.itemDetail!.type),
              ]
          )),
          SizedBox(height: defaultPadding/2,),
          Text.rich(TextSpan(
              children: [
                TextSpan(text: "Description: \n", style: Theme.of(context).textTheme.subtitle1),
                TextSpan(text: controller.itemDetail!.description),
              ]
          )),
          SizedBox(height: defaultPadding/2,),
          Text.rich(TextSpan(
              children: [
                TextSpan(text: "Created time: \n", style: Theme.of(context).textTheme.subtitle1),
                TextSpan(text: DateFormat.yMd().add_jm().format(controller.itemDetail!.createdTime!.toLocal())),
              ]
          )),
          SizedBox(height: defaultPadding/2,),
          Text.rich(TextSpan(
              children: [
                TextSpan(text: "Last updated time: \n", style: Theme.of(context).textTheme.subtitle1),
                TextSpan(text: DateFormat.yMd().add_jm().format(controller.itemDetail!.lastUpdatedTime!.toLocal())),
              ]
          )),
        ],
      );
    });
  }
}

class CustomDialog extends StatelessWidget {
  final AddNewEmotionalLogController controller = Get.find();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  void _submitForm() {
    if (_key.currentState!.validate()) {
      _key.currentState!.save();

      controller.addNewItem(EmotionalLog(
          email: _emailController.text,
          type: controller.currentType.value,
          description: _descriptionController.text));
    }
  }

  Widget dialogContent(BuildContext context) {
    var types = [
      "happy",
      "grateful",
      "positive",
      "tired",
      "sleepy",
      "angry",
      "disappointed",
    ];

    return Container(
      margin: EdgeInsets.only(left: 0.0, right: 0.0),
      child: Stack(
        children: <Widget>[
          Container(
            width: 400,
            padding: EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 15
            ),
            margin: EdgeInsets.only(top: 13.0, right: 8.0),
            decoration: BoxDecoration(
                color: Color(0xFF242430),
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 0.0,
                    offset: Offset(0.0, 0.0),
                  ),
                ]),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text('Add new item', style: Theme.of(context).textTheme.subtitle1,),
                SizedBox(
                  height: 20.0,
                ),
                Form(
                  key: _key,
                  child: Column(
                    children: [
                      TextFormField(
                        style: TextStyle(
                          color: Color(0xFF999999),
                        ),
                        decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(
                              color: Color(0xFF999999),
                              fontWeight: FontWeight.bold),
                          // filled: true,
                          // isDense: true,
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(width: 2, color: Color(0xFF999999)),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(width: 2, color: Color(0xFF999999)),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(width: 2, color: Colors.redAccent),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(width: 2, color: Colors.redAccent),
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        cursorColor: Color(0xFF999999),
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailController,
                        validator: (val) {
                          if (val == "") {
                            return 'Email is required';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: defaultPadding,
                      ),
                      DropdownButtonFormField(items: types.map((String val) {
                        return DropdownMenuItem(
                          value: val,
                          child: Row(
                            children: [Text(val.toUpperCase())],
                          ),
                        );
                      }).toList(),
                        value: controller.currentType.value,
                        onChanged: (String? newValue) {
                          controller.currentType.value = newValue!;
                        },
                        decoration: InputDecoration(
                            labelText: 'Type',
                            labelStyle: TextStyle(
                                color: Color(0xFF999999),
                                fontWeight: FontWeight.bold),
                            // filled: true,
                            // isDense: true,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 2, color: Color(0xFF999999)),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 2, color: Color(0xFF999999)),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(width: 2, color: Colors.redAccent),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(width: 2, color: Colors.redAccent),
                              borderRadius: BorderRadius.circular(15),
                            )),
                        // value: controller.,
                      ),
                      SizedBox(
                        height: defaultPadding,
                      ),
                      TextFormField(
                        style: TextStyle(
                          color: Color(0xFF999999),
                        ),
                        decoration: InputDecoration(
                            labelText: 'Description',
                            labelStyle: TextStyle(
                                color: Color(0xFF999999),
                                fontWeight: FontWeight.bold),
                            // filled: true,
                            // isDense: true,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 2, color: Color(0xFF999999)),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 2, color: Color(0xFF999999)),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(width: 2, color: Colors.redAccent),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(width: 2, color: Colors.redAccent),
                              borderRadius: BorderRadius.circular(15),
                            )),
                        controller: _descriptionController,
                        cursorColor: Color(0xFF999999),
                        validator: (value) {
                          if (value == "") {
                            return 'Description is required.';
                          }
                          return null;
                        },
                        minLines: 5,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                      ),
                      SizedBox(
                        height: defaultPadding,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _submitForm();
                        },
                        child: Text('Submit'),

                        // onPressed: _controller.state is LoginLoading
                        //     ? () {}
                        //     : _onLoginButtonPressed,
                        // child: (_controller.state is LoginLoading)
                        //     ? SizedBox(
                        //   child: CircularProgressIndicator(),
                        //   height: 20.0,
                        //   width: 20.0,
                        // )
                        //     : Text('LOG IN'),
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all<EdgeInsets>(
                              EdgeInsets.symmetric(
                                  horizontal: defaultPadding * 2,
                                  vertical: defaultPadding)),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.deepPurpleAccent),
                        ),
                      ),
                      // if (_controller.state is LoginFailure)
                      //   Padding(
                      //     padding: const EdgeInsets.only(top: defaultPadding),
                      //     child: Text(
                      //       (_controller.state as LoginFailure).error,
                      //       textAlign: TextAlign.center,
                      //       style: TextStyle(
                      //           color: Get.theme.errorColor // easy way to access theme
                      //       ),
                      //     ),
                      //   ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 0.0,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Align(
                alignment: Alignment.topRight,
                child: CircleAvatar(
                  radius: 14.0,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.close, color: Colors.red),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

