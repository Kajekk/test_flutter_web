import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_flutter_web/constants/barrel.dart';
import 'package:test_flutter_web/data/models/barrel.dart';
import 'package:test_flutter_web/modules/user_access_management/barrel.dart';
import 'package:test_flutter_web/modules/user_access_management/controllers/barrel.dart';

class RoleItemDetailInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    EditRoleController controller = Get.find();
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
            TextSpan(text: controller.itemDetail!.name),
          ])),
          SizedBox(
            height: defaultPadding / 2,
          ),
          Text.rich(TextSpan(children: [
            TextSpan(
                text: "Description: \n",
                style: Theme.of(context).textTheme.subtitle1),
            TextSpan(text: controller.itemDetail!.description),
          ])),
          SizedBox(
            height: defaultPadding / 2,
          ),
          Text.rich(TextSpan(children: [
            TextSpan(
                text: "Permissions: \n",
                style: Theme.of(context).textTheme.subtitle1),
            ...?controller.itemDetail!.permissionList?.map((e) => TextSpan(text: "- " + e.name! + "\n")).toList(),
          ])),
        ],
      );
    });
  }
}

class AddRoleDialog extends StatelessWidget {
  final AddNewRoleController controller = Get.find();
  final PermissionModuleController pModuleController = Get.find();
  final OrganisationController organisationController = Get.find();
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
                        ...nameField(),
                        ...descriptionField(),
                        ...permissionField(),

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
                        if (controller.state is AddRoleFailure)
                          Padding(
                            padding: EdgeInsets.only(top: defaultPadding / 2),
                            child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  (controller.state as AddRoleFailure)
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
  List<Widget> descriptionField() {
    return <Widget>[
      TextFormField(
        style: TextStyle(
          color: Color(0xFF999999),
        ),
        decoration: InputDecoration(
          labelText: 'Description',
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
        controller: controller.descriptionController,
        validator: (val) {
          if (val == "") {
            return 'Description is required';
          }
          return null;
        },
      ),
      SizedBox(
        height: defaultPadding,
      ),
    ];
  }
  List<Widget> permissionField() {
    if (controller.organisation.value.isEmpty) {
      return <Widget>[
        Text('Permissions'),
        SizedBox(height: defaultPadding / 2),
        Center(child: Text('Choose organisation first')),
        SizedBox(height: defaultPadding),
      ];
    }

    var permissionList = <Permission>[];
    var moduleList = <PermissionModule>[];

    for (var i=0; i<organisationController.allItemsList.length; i++) {
      if (organisationController.allItemsList[i].id == controller.organisation.value) {
        permissionList = organisationController.allItemsList[i].permissionList ?? [];
        var moduleMap = Map<String, bool>();
        permissionList.forEach((e) {
          moduleMap.putIfAbsent(e.moduleId!, () => true);
        });
        moduleMap.forEach((key, value) {
          moduleList.addAll(pModuleController.allItemsList.where((e) => e.id == key));
        });
        break;
      }
    }

    return <Widget>[
      Text('Permissions'),
      SizedBox(height: defaultPadding / 2),
      ...moduleList.map((m) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Checkbox(
                value: (controller.selectedModules.contains(m.id) && controller.selectedPermissions.any((e) => e.moduleId == m.id)),
                onChanged: (bool? selected) {
                  if (selected != null) {
                    if (selected) {
                      controller.selectedModules.add(m.id!);
                      var pList = permissionList.where((e) => e.moduleId == m.id);
                      controller.selectedPermissions.addAll(pList);
                    } else {
                      controller.selectedModules.remove(m.id!);
                      controller.selectedPermissions.removeWhere((e) => e.moduleId == m.id);
                    }
                  }
                },
                splashRadius: 0,
                activeColor: Colors.deepPurpleAccent,
              ),
              SizedBox(width: defaultPadding / 2),
              Text(m.name!),
            ],),
            SizedBox(width: defaultPadding / 2),
            Padding(
              padding: const EdgeInsets.only(left: defaultPadding * 1.5),
              child: Column(
                children: [
                  ...permissionList.map((p) {
                    if (m.id != p.moduleId) {
                      return Container();
                    }
                    return Row(children: [
                      Checkbox(
                        value: controller.selectedPermissions.any((e) => e.id == p.id),
                        onChanged: (bool? selected) {
                          if (selected != null) {
                            if (selected) {
                              controller.selectedPermissions.add(p);
                            } else {
                              controller.selectedPermissions.removeWhere((e) => e.id == p.id);
                            }
                          }
                        },
                        splashRadius: 0,
                        activeColor: Colors.deepPurpleAccent,
                      ),
                      SizedBox(width: defaultPadding / 2),
                      Expanded(child: Text(p.name!)),
                    ],);
                  }).toList(),
                ],
              ),
            ),
            Divider(color: bodyTextColor),
          ],
        );
      }).toList(),
      SizedBox(
        height: defaultPadding,
      ),
    ];
  }
  List<Widget> organisationField() {
    var organisationList = <Organisation>[];
    organisationList = organisationController.allItemsList;
    return <Widget>[
      DropdownButtonFormField(
        items: organisationList.map((e) {
          return DropdownMenuItem(
            value: e.id,
            child: Row(
              children: [Text(e.name!.toUpperCase())],
            ),
          );
        }).toList(),
        onChanged: (String? newValue) {
          controller.organisation.value = newValue!;
          controller.selectedPermissions.value = [];
          controller.selectedModules.value = [];
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
}

class EditRoleDialog extends StatelessWidget {
  final EditRoleController controller = Get.find();
  final PermissionModuleController pModuleController = Get.find();
  final OrganisationController organisationController = Get.find();
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
                        ...nameField(),
                        ...descriptionField(),
                        ...permissionField(),

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
                        if (controller.state is EditRoleFailure)
                          Padding(
                            padding: EdgeInsets.only(top: defaultPadding / 2),
                            child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  (controller.state as EditRoleFailure)
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
  List<Widget> descriptionField() {
    return <Widget>[
      TextFormField(
        style: TextStyle(
          color: Color(0xFF999999),
        ),
        decoration: InputDecoration(
          labelText: 'Description',
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
        controller: controller.descriptionController,
        validator: (val) {
          if (val == "") {
            return 'Description is required';
          }
          return null;
        },
      ),
      SizedBox(
        height: defaultPadding,
      ),
    ];
  }
  List<Widget> permissionField() {
    if (controller.organisation.value.isEmpty) {
      return <Widget>[
        Text('Permissions'),
        SizedBox(height: defaultPadding / 2),
        Center(child: Text('Choose organisation first')),
        SizedBox(height: defaultPadding),
      ];
    }

    var permissionList = <Permission>[];
    var moduleList = <PermissionModule>[];

    for (var i=0; i<organisationController.allItemsList.length; i++) {
      if (organisationController.allItemsList[i].id == controller.organisation.value) {
        permissionList = organisationController.allItemsList[i].permissionList ?? [];
        var moduleMap = Map<String, bool>();
        permissionList.forEach((e) {
          moduleMap.putIfAbsent(e.moduleId!, () => true);
        });
        moduleMap.forEach((key, value) {
          moduleList.addAll(pModuleController.allItemsList.where((e) => e.id == key));
        });
        break;
      }
    }

    return <Widget>[
      Text('Permissions'),
      SizedBox(height: defaultPadding / 2),
      ...moduleList.map((m) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Checkbox(
                value: (controller.selectedModules.contains(m.id) && controller.selectedPermissions.any((e) => e.moduleId == m.id)),
                onChanged: (bool? selected) {
                  if (selected != null) {
                    if (selected) {
                      controller.selectedModules.add(m.id!);
                      var pList = permissionList.where((e) => e.moduleId == m.id);
                      controller.selectedPermissions.addAll(pList);
                    } else {
                      controller.selectedModules.remove(m.id!);
                      controller.selectedPermissions.removeWhere((e) => e.moduleId == m.id);
                    }
                  }
                },
                splashRadius: 0,
                activeColor: Colors.deepPurpleAccent,
              ),
              SizedBox(width: defaultPadding / 2),
              Text(m.name!),
            ],),
            SizedBox(width: defaultPadding / 2),
            Padding(
              padding: const EdgeInsets.only(left: defaultPadding * 1.5),
              child: Column(
                children: [
                  ...permissionList.map((p) {
                    if (m.id != p.moduleId) {
                      return Container();
                    }
                    return Row(children: [
                      Checkbox(
                        value: controller.selectedPermissions.any((e) => e.id == p.id),
                        onChanged: (bool? selected) {
                          if (selected != null) {
                            if (selected) {
                              controller.selectedPermissions.add(p);
                            } else {
                              controller.selectedPermissions.removeWhere((e) => e.id == p.id);
                            }
                          }
                        },
                        splashRadius: 0,
                        activeColor: Colors.deepPurpleAccent,
                      ),
                      SizedBox(width: defaultPadding / 2),
                      Expanded(child: Text(p.name!)),
                    ],);
                  }).toList(),
                ],
              ),
            ),
            Divider(color: bodyTextColor),
          ],
        );
      }).toList(),
      SizedBox(
        height: defaultPadding,
      ),
    ];
  }
  List<Widget> organisationField() {
    var organisationList = <Organisation>[];
    organisationList = organisationController.allItemsList;
    return <Widget>[
      DropdownButtonFormField(
        items: organisationList.map((e) {
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
          controller.selectedPermissions.value = [];
          controller.selectedModules.value = [];
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
}