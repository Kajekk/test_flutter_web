import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:test_flutter_web/constants/barrel.dart';
import 'package:test_flutter_web/global_widgets/barrel.dart';
import 'package:test_flutter_web/modules/account_management/barrel.dart';
import 'package:test_flutter_web/modules/user_access_management/controllers/barrel.dart';

class AccountItemDetailInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    EditAccountController controller = Get.find();
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
          Text.rich(TextSpan(children: [
            TextSpan(
                text: "Uid: \n",
                style: Theme.of(context).textTheme.subtitle1),
            TextSpan(text: controller.itemDetail!.uid),
          ])),
          SizedBox(
            height: defaultPadding / 2,
          ),
          Text.rich(TextSpan(children: [
            TextSpan(
                text: "Email: \n",
                style: Theme.of(context).textTheme.subtitle1),
            TextSpan(text: controller.itemDetail!.email),
          ])),
          SizedBox(
            height: defaultPadding / 2,
          ),
          Text.rich(TextSpan(children: [
            TextSpan(
                text: "Name: \n",
                style: Theme.of(context).textTheme.subtitle1),
            TextSpan(text: controller.itemDetail!.name),
          ])),
          SizedBox(
            height: defaultPadding / 2,
          ),
          Text.rich(TextSpan(children: [
            TextSpan(
                text: "Organisation: \n",
                style: Theme.of(context).textTheme.subtitle1),
            TextSpan(text: controller.itemDetail!.organisationName),
          ])),
          SizedBox(
            height: defaultPadding / 2,
          ),
          Text.rich(TextSpan(children: [
            TextSpan(
                text: "Role: \n",
                style: Theme.of(context).textTheme.subtitle1),
            TextSpan(text: controller.itemDetail!.roleName),
          ])),
          SizedBox(
            height: defaultPadding / 2,
          ),
          Text.rich(TextSpan(children: [
            TextSpan(
                text: "Phone Number: \n",
                style: Theme.of(context).textTheme.subtitle1),
            TextSpan(text: controller.itemDetail!.phoneNumber),
          ])),
          SizedBox(
            height: defaultPadding / 2,
          ),
          Text.rich(TextSpan(children: [
            TextSpan(
                text: "Gender: \n",
                style: Theme.of(context).textTheme.subtitle1),
            TextSpan(text: controller.itemDetail!.gender),
          ])),
          SizedBox(
            height: defaultPadding / 2,
          ),
          Text.rich(TextSpan(children: [
            TextSpan(
                text: "Home address: \n",
                style: Theme.of(context).textTheme.subtitle1),
            TextSpan(text: controller.itemDetail!.homeAddress),
          ])),
          SizedBox(
            height: defaultPadding / 2,
          ),
          Text.rich(TextSpan(children: [
            TextSpan(
                text: "Date Of Birth: \n",
                style: Theme.of(context).textTheme.subtitle1),
            TextSpan(text: controller.itemDetail!.dateOfBirth != null ? DateFormat.yMd().format(controller.itemDetail!.dateOfBirth!.toLocal()) : ""),
          ])),
          SizedBox(
            height: defaultPadding / 2,
          ),
        ],
      );
    });
  }
}

class AddAccountDialog extends StatelessWidget {
  final AddNewAccountController controller = Get.find();
  final OrganisationController organisationController = Get.find();
  final RoleController roleController = Get.find();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Dialog(
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        child: dialogContent(context),
      ),
    );
  }

  void _submitForm() {
    if (_key.currentState!.validate()) {
      controller.addNewItem();
    }
  }

  Widget dialogContent(BuildContext context) {
    return Obx(() {
      return Container(
        margin: EdgeInsets.only(left: 0.0, right: 0.0),
        child: Stack(
          children: <Widget>[
            Container(
              width: 400,
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
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
                  Text(
                    'Add new item',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Form(
                    key: _key,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...organisationField(),
                        ...emailField(),
                        ...passwordField(),
                        ...nameField(),
                        ...roleField(),
                        ...genderField(),
                        ...phoneNumberField(),
                        ...addressField(),
                        ...dateOfBirthField(),

                        Align(
                          alignment: Alignment.center,
                          child: ElevatedButton(
                            onPressed: () {
                              _submitForm();
                            },
                            child: Text('Submit'),
                            style: ButtonStyle(
                              padding: MaterialStateProperty.all<EdgeInsets>(
                                  EdgeInsets.symmetric(
                                      horizontal: defaultPadding,
                                      vertical: defaultPadding / 1.5)),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.deepPurpleAccent),
                            ),
                          ),
                        ),
                        if (controller.state is AddAccountFailure)
                          Padding(
                            padding: EdgeInsets.only(top: defaultPadding / 2),
                            child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  (controller.state as AddAccountFailure)
                                      .message,
                                  style: TextStyle(color: Get.theme.errorColor),
                                )),
                          ),
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
                  controller.clear();
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
    });
  }

  List<Widget> emailField() {
    return <Widget>[
      TextFormField(
        style: TextStyle(
          color: Color(0xFF999999),
        ),
        decoration: InputDecoration(
          labelText: 'Email',
          labelStyle:
          TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.bold),
          // filled: true,
          // isDense: true,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: Color(0xFF999999)),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: Color(0xFF999999)),
            borderRadius: BorderRadius.circular(15),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: Colors.redAccent),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: Colors.redAccent),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        cursorColor: Color(0xFF999999),
        keyboardType: TextInputType.text,
        controller: controller.emailController,
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
    ];
  }
  List<Widget> nameField() {
    return <Widget>[
      TextFormField(
        style: TextStyle(
          color: Color(0xFF999999),
        ),
        decoration: InputDecoration(
          labelText: 'Name',
          labelStyle:
          TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.bold),
          // filled: true,
          // isDense: true,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: Color(0xFF999999)),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: Color(0xFF999999)),
            borderRadius: BorderRadius.circular(15),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: Colors.redAccent),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: Colors.redAccent),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        cursorColor: Color(0xFF999999),
        keyboardType: TextInputType.text,
        controller: controller.nameController,
        validator: (val) {
          if (val == "") {
            return 'Name is required';
          }
          return null;
        },
      ),
      SizedBox(
        height: defaultPadding,
      ),
    ];
  }
  List<Widget> passwordField() {
    return <Widget>[
      TextFormField(
        style: TextStyle(
          color: Color(0xFF999999),
        ),
        decoration: InputDecoration(
          labelText: 'Password',
          labelStyle:
          TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.bold),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: Color(0xFF999999)),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: Color(0xFF999999)),
            borderRadius: BorderRadius.circular(15),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: Colors.redAccent),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: Colors.redAccent),
            borderRadius: BorderRadius.circular(15),
          ),
          suffixIcon: IconButton(
            icon: controller.obscureText.value
                ? Icon(Icons.visibility)
                : Icon(Icons.visibility_off),
            onPressed: () {
              controller.obscureText.value = !controller.obscureText.value;
            },
            color: bodyTextColor,
          ),
        ),
        cursorColor: Color(0xFF999999),
        keyboardType: TextInputType.text,
        controller: controller.passwordController,
        obscureText: controller.obscureText.value,
        validator: (val) {
          if (val == "") {
            return 'Password is required';
          }
          return null;
        },
      ),
      SizedBox(
        height: defaultPadding,
      ),
    ];
  }
  List<Widget> organisationField() {
    return <Widget>[
      DropdownButtonFormField(
        items: organisationController.allItemsList.map((e) {
          return DropdownMenuItem(
            value: e.id,
            child: Row(
              children: [Text(e.name!.toUpperCase())],
            ),
          );
        }).toList(),
        onChanged: (String? newValue) {
          controller.organisation.value = newValue!;
          var newRole = roleController.allItemsList.firstWhere((e) => e.organisation == newValue);
          controller.role.value = newRole.id!;
        },
        validator: (val) {
          if (val == null || val == "") {
            return 'Required';
          }
          return null;
        },
        decoration: InputDecoration(
            labelText: 'Organisation',
            labelStyle: TextStyle(
                color: Color(0xFF999999), fontWeight: FontWeight.bold),
            // filled: true,
            // isDense: true,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: Color(0xFF999999)),
              borderRadius: BorderRadius.circular(15),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: Color(0xFF999999)),
              borderRadius: BorderRadius.circular(15),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: Colors.redAccent),
              borderRadius: BorderRadius.circular(15),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: Colors.redAccent),
              borderRadius: BorderRadius.circular(15),
            )),
      ),
      SizedBox(
        height: defaultPadding,
      ),
    ];
  }
  List<Widget> roleField() {
    if (controller.organisation.value.isEmpty) {
      return <Widget>[
        TextFormField(
          style: TextStyle(
            color: Color(0xFF999999),
          ),
          decoration: InputDecoration(
            labelText: 'Role',
            labelStyle:
            TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.bold),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: Color(0xFF999999)),
              borderRadius: BorderRadius.circular(15),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: Color(0xFF999999)),
              borderRadius: BorderRadius.circular(15),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: Colors.redAccent),
              borderRadius: BorderRadius.circular(15),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: Colors.redAccent),
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          cursorColor: Color(0xFF999999),
          initialValue: "Choose organisation first",
          readOnly: true,
          showCursor: false,
          validator: (val) {
            if (val == "Choose organisation first") {
              return 'Choose organisation first to pick role';
            }
            return null;
          },
        ),
        SizedBox(
          height: defaultPadding,
        ),
      ];
    }
    var roleList = roleController.allItemsList.where((e) => e.organisation == controller.organisation.value).toList();
    return <Widget>[
      DropdownButtonFormField(
        items: roleList.map((e) {
          return DropdownMenuItem(
            value: e.id,
            child: Row(
              children: [Text(e.name!.toUpperCase())],
            ),
          );
        }).toList(),
        value: controller.role.value,
        onChanged: (String? newValue) {
          if (newValue != null) {
            controller.role.value = newValue;
          }
        },
        validator: (val) {
          if (val == null || val == "") {
            return 'Required';
          }
          return null;
        },
        decoration: InputDecoration(
            labelText: 'Role',
            labelStyle: TextStyle(
                color: Color(0xFF999999), fontWeight: FontWeight.bold),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: Color(0xFF999999)),
              borderRadius: BorderRadius.circular(15),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: Color(0xFF999999)),
              borderRadius: BorderRadius.circular(15),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: Colors.redAccent),
              borderRadius: BorderRadius.circular(15),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: Colors.redAccent),
              borderRadius: BorderRadius.circular(15),
            )),
      ),
      SizedBox(
        height: defaultPadding,
      ),
    ];
  }
  List<Widget> genderField() {
    return <Widget>[
      Text('Gender:', style: TextStyle(fontWeight: FontWeight.bold)),
      SizedBox(height: defaultPadding / 3),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Radio(
            activeColor: Colors.deepPurpleAccent,
            value: "male",
            groupValue: controller.gender.value,
            onChanged: (String? value) {
              controller.gender.value = value!;
            },
          ),
          Text('Male', style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(width: defaultPadding),
          Radio(
            activeColor: Colors.deepPurpleAccent,
            value: "female",
            groupValue: controller.gender.value,
            onChanged: (String? value) {
              controller.gender.value = value!;
            },
          ),
          Text('Female', style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
      SizedBox(
        height: defaultPadding,
      ),
    ];
  }
  List<Widget> phoneNumberField() {
    return <Widget>[
      TextFormField(
        style: TextStyle(
          color: Color(0xFF999999),
        ),
        decoration: InputDecoration(
          labelText: 'Phone Number',
          labelStyle:
          TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.bold),
          // filled: true,
          // isDense: true,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: Color(0xFF999999)),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: Color(0xFF999999)),
            borderRadius: BorderRadius.circular(15),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: Colors.redAccent),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: Colors.redAccent),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        cursorColor: Color(0xFF999999),
        keyboardType: TextInputType.text,
        controller: controller.phoneNumberController,
      ),
      SizedBox(
        height: defaultPadding,
      ),
    ];
  }
  List<Widget> addressField() {
    return <Widget>[
      TextFormField(
        style: TextStyle(
          color: Color(0xFF999999),
        ),
        decoration: InputDecoration(
          labelText: 'Address',
          labelStyle:
          TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.bold),
          // filled: true,
          // isDense: true,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: Color(0xFF999999)),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: Color(0xFF999999)),
            borderRadius: BorderRadius.circular(15),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: Colors.redAccent),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: Colors.redAccent),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        cursorColor: Color(0xFF999999),
        keyboardType: TextInputType.text,
        controller: controller.addressController,
      ),
      SizedBox(
        height: defaultPadding,
      ),
    ];
  }
  List<Widget> dateOfBirthField() {
    return <Widget>[
      DatePickerField(
        controller: controller.dateOfBirthController,
        labelText: 'Date Of Birth',
        isRequireValidate: false,
      ),
      SizedBox(height: defaultPadding,),
    ];
  }
}

class EditAccountDialog extends StatelessWidget {
  final EditAccountController controller = Get.find();
  final OrganisationController organisationController = Get.find();
  final RoleController roleController = Get.find();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Dialog(
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        child: dialogContent(context),
      ),
    );
  }

  void _submitForm() {
    if (_key.currentState!.validate()) {
      controller.editItem();
    }
  }

  Widget dialogContent(BuildContext context) {
    return Obx(() {
      return Container(
        margin: EdgeInsets.only(left: 0.0, right: 0.0),
        child: Stack(
          children: <Widget>[
            Container(
              width: 650,
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
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
                  Text(
                    'Update item',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Form(
                    key: _key,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...organisationField(),
                        ...emailField(),
                        ...passwordField(),
                        ...nameField(),
                        ...roleField(),
                        ...genderField(),
                        ...phoneNumberField(),
                        ...addressField(),
                        ...dateOfBirthField(),

                        Align(
                          alignment: Alignment.center,
                          child: ElevatedButton(
                              onPressed: () {
                                _submitForm();
                              },
                              child: Text('Submit'),
                              style: ButtonStyle(
                                  padding: MaterialStateProperty.all<EdgeInsets>(
                                      EdgeInsets.symmetric(
                                          horizontal: defaultPadding,
                                          vertical: defaultPadding / 1.5)),
                                  backgroundColor: MaterialStateProperty.all<Color>(
                                      Colors.deepPurpleAccent))
                          ),
                        ),
                        if (controller.state is EditAccountFailure)
                          Padding(
                            padding: EdgeInsets.only(top: defaultPadding / 2),
                            child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  (controller.state as EditAccountFailure)
                                      .message,
                                  style: TextStyle(color: Get.theme.errorColor),
                                )),
                          ),
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
                  controller.clearEdit();
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
    });
  }

  List<Widget> emailField() {
    return <Widget>[
      TextFormField(
        style: TextStyle(
          color: Color(0xFF999999),
        ),
        decoration: InputDecoration(
          labelText: 'Email',
          labelStyle:
          TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.bold),
          // filled: true,
          // isDense: true,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: Color(0xFF999999)),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: Color(0xFF999999)),
            borderRadius: BorderRadius.circular(15),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: Colors.redAccent),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: Colors.redAccent),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        cursorColor: Color(0xFF999999),
        keyboardType: TextInputType.text,
        controller: controller.emailController,
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
    ];
  }
  List<Widget> nameField() {
    return <Widget>[
      TextFormField(
        style: TextStyle(
          color: Color(0xFF999999),
        ),
        decoration: InputDecoration(
          labelText: 'Name',
          labelStyle:
          TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.bold),
          // filled: true,
          // isDense: true,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: Color(0xFF999999)),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: Color(0xFF999999)),
            borderRadius: BorderRadius.circular(15),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: Colors.redAccent),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: Colors.redAccent),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        cursorColor: Color(0xFF999999),
        keyboardType: TextInputType.text,
        controller: controller.nameController,
        validator: (val) {
          if (val == "") {
            return 'Name is required';
          }
          return null;
        },
      ),
      SizedBox(
        height: defaultPadding,
      ),
    ];
  }
  List<Widget> passwordField() {
    return <Widget>[
      TextFormField(
        style: TextStyle(
          color: Color(0xFF999999),
        ),
        decoration: InputDecoration(
          labelText: 'Password',
          labelStyle:
          TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.bold),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: Color(0xFF999999)),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: Color(0xFF999999)),
            borderRadius: BorderRadius.circular(15),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: Colors.redAccent),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: Colors.redAccent),
            borderRadius: BorderRadius.circular(15),
          ),
          suffixIcon: IconButton(
            icon: controller.obscureText.value
                ? Icon(Icons.visibility)
                : Icon(Icons.visibility_off),
            onPressed: () {
              controller.obscureText.value = !controller.obscureText.value;
            },
            color: bodyTextColor,
          ),
        ),
        cursorColor: Color(0xFF999999),
        keyboardType: TextInputType.text,
        controller: controller.passwordController,
        obscureText: controller.obscureText.value,
      ),
      SizedBox(
        height: defaultPadding,
      ),
    ];
  }
  List<Widget> organisationField() {
    return <Widget>[
      DropdownButtonFormField(
        items: organisationController.allItemsList.map((e) {
          return DropdownMenuItem(
            value: e.id,
            child: Row(
              children: [Text(e.name!.toUpperCase())],
            ),
          );
        }).toList(),
        value: controller.organisation.value,
        onChanged: (String? newValue) {
          controller.organisation.value = newValue!;
          var newRole = roleController.allItemsList.firstWhere((e) => e.organisation == newValue);
          controller.role.value = newRole.id!;
        },
        validator: (val) {
          if (val == null || val == "") {
            return 'Required';
          }
          return null;
        },
        decoration: InputDecoration(
            labelText: 'Organisation',
            labelStyle: TextStyle(
                color: Color(0xFF999999), fontWeight: FontWeight.bold),
            // filled: true,
            // isDense: true,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: Color(0xFF999999)),
              borderRadius: BorderRadius.circular(15),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: Color(0xFF999999)),
              borderRadius: BorderRadius.circular(15),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: Colors.redAccent),
              borderRadius: BorderRadius.circular(15),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: Colors.redAccent),
              borderRadius: BorderRadius.circular(15),
            )),
      ),
      SizedBox(
        height: defaultPadding,
      ),
    ];
  }
  List<Widget> roleField() {
    if (controller.organisation.value.isEmpty) {
      return <Widget>[
        TextFormField(
          style: TextStyle(
            color: Color(0xFF999999),
          ),
          decoration: InputDecoration(
            labelText: 'Role',
            labelStyle:
            TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.bold),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: Color(0xFF999999)),
              borderRadius: BorderRadius.circular(15),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: Color(0xFF999999)),
              borderRadius: BorderRadius.circular(15),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: Colors.redAccent),
              borderRadius: BorderRadius.circular(15),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: Colors.redAccent),
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          cursorColor: Color(0xFF999999),
          initialValue: "Choose organisation first",
          readOnly: true,
          showCursor: false,
          validator: (val) {
            if (val == "Choose organisation first") {
              return 'Choose organisation first to pick role';
            }
            return null;
          },
        ),
        SizedBox(
          height: defaultPadding,
        ),
      ];
    }
    var roleList = roleController.allItemsList.where((e) => e.organisation == controller.organisation.value).toList();
    return <Widget>[
      DropdownButtonFormField(
        items: roleList.map((e) {
          return DropdownMenuItem(
            value: e.id,
            child: Row(
              children: [Text(e.name!.toUpperCase())],
            ),
          );
        }).toList(),
        value: controller.role.value,
        onChanged: (String? newValue) {
          if (newValue != null) {
            controller.role.value = newValue;
          }
        },
        validator: (val) {
          if (val == null || val == "") {
            return 'Required';
          }
          return null;
        },
        decoration: InputDecoration(
            labelText: 'Role',
            labelStyle: TextStyle(
                color: Color(0xFF999999), fontWeight: FontWeight.bold),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: Color(0xFF999999)),
              borderRadius: BorderRadius.circular(15),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: Color(0xFF999999)),
              borderRadius: BorderRadius.circular(15),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: Colors.redAccent),
              borderRadius: BorderRadius.circular(15),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: Colors.redAccent),
              borderRadius: BorderRadius.circular(15),
            )),
      ),
      SizedBox(
        height: defaultPadding,
      ),
    ];
  }
  List<Widget> genderField() {
    return <Widget>[
      Text('Gender:', style: TextStyle(fontWeight: FontWeight.bold)),
      SizedBox(height: defaultPadding / 3),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Radio(
            activeColor: Colors.deepPurpleAccent,
            value: "male",
            groupValue: controller.gender.value,
            onChanged: (String? value) {
              controller.gender.value = value!;
            },
          ),
          Text('Male', style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(width: defaultPadding),
          Radio(
            activeColor: Colors.deepPurpleAccent,
            value: "female",
            groupValue: controller.gender.value,
            onChanged: (String? value) {
              controller.gender.value = value!;
            },
          ),
          Text('Female', style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
      SizedBox(
        height: defaultPadding,
      ),
    ];
  }
  List<Widget> phoneNumberField() {
    return <Widget>[
      TextFormField(
        style: TextStyle(
          color: Color(0xFF999999),
        ),
        decoration: InputDecoration(
          labelText: 'Phone Number',
          labelStyle:
          TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.bold),
          // filled: true,
          // isDense: true,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: Color(0xFF999999)),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: Color(0xFF999999)),
            borderRadius: BorderRadius.circular(15),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: Colors.redAccent),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: Colors.redAccent),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        cursorColor: Color(0xFF999999),
        keyboardType: TextInputType.text,
        controller: controller.phoneNumberController,
      ),
      SizedBox(
        height: defaultPadding,
      ),
    ];
  }
  List<Widget> addressField() {
    return <Widget>[
      TextFormField(
        style: TextStyle(
          color: Color(0xFF999999),
        ),
        decoration: InputDecoration(
          labelText: 'Address',
          labelStyle:
          TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.bold),
          // filled: true,
          // isDense: true,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: Color(0xFF999999)),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: Color(0xFF999999)),
            borderRadius: BorderRadius.circular(15),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: Colors.redAccent),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: Colors.redAccent),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        cursorColor: Color(0xFF999999),
        keyboardType: TextInputType.text,
        controller: controller.addressController,
      ),
      SizedBox(
        height: defaultPadding,
      ),
    ];
  }
  List<Widget> dateOfBirthField() {
    return <Widget>[
      DatePickerField(
        controller: controller.dateOfBirthController,
        labelText: 'Date Of Birth',
        isRequireValidate: false,
      ),
      SizedBox(height: defaultPadding,),
    ];
  }
}