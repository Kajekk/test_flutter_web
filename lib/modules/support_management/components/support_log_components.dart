import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:test_flutter_web/constants/barrel.dart';
import 'package:test_flutter_web/data/barrel.dart';
import 'package:test_flutter_web/global_widgets/barrel.dart';
import 'package:test_flutter_web/modules/support_management/barrel.dart';

class SupportLogItemDetailInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    EditSupportLogController controller = Get.find();
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
                text: "Email: \n",
                style: Theme.of(context).textTheme.subtitle1),
            TextSpan(text: controller.itemDetail!.email),
          ])),
          SizedBox(
            height: defaultPadding / 2,
          ),
          Text.rich(TextSpan(children: [
            TextSpan(
                text: "For Email: \n",
                style: Theme.of(context).textTheme.subtitle1),
            TextSpan(text: controller.itemDetail!.forEmail),
          ]), maxLines: 10, overflow: TextOverflow.ellipsis,),
          SizedBox(
            height: defaultPadding / 2,
          ),
          Text.rich(TextSpan(children: [
            TextSpan(
                text: "Type: \n",
                style: Theme.of(context).textTheme.subtitle1),
            TextSpan(text: controller.itemDetail!.type),
          ])),
          SizedBox(
            height: defaultPadding / 2,
          ),
          Text.rich(TextSpan(children: [
            TextSpan(
                text: "Start At: \n",
                style: Theme.of(context).textTheme.subtitle1),
            TextSpan(text: DateFormat.yMd().add_jm().format(
                controller.itemDetail!.startAt!.toLocal())),
          ])),
          SizedBox(
            height: defaultPadding / 2,
          ),
          Text.rich(TextSpan(children: [
            TextSpan(
                text: "End At: \n",
                style: Theme.of(context).textTheme.subtitle1),
            TextSpan(text: DateFormat.yMd().add_jm().format(
                controller.itemDetail!.endAt!.toLocal())),
          ])),
          SizedBox(
            height: defaultPadding / 2,
          ),
          Text.rich(TextSpan(children: [
            TextSpan(
                text: "Observations: \n",
                style: Theme.of(context).textTheme.subtitle1),
            ...?controller.itemDetail!.observations?.map((e) {
              return TextSpan(children: [
                TextSpan(text: "- " + DateFormat.yMd().add_jm().format(e.time!.toLocal()) + "\n"),
                TextSpan(text: e.description! + "\n"),
              ]);
            }).toList(),
          ])),
          SizedBox(
            height: defaultPadding / 2,
          ),
          Text.rich(TextSpan(children: [
            TextSpan(
                text: "Metrics: \n",
                style: Theme.of(context).textTheme.subtitle1),
            ...?controller.itemDetail!.metrics?.map((e) {
              return TextSpan(children: [
                TextSpan(text: "- " + e.name! + "\n"),
                TextSpan(text: e.value!.toString() + "\n"),
              ]);
            }).toList(),
          ])),
          SizedBox(
            height: defaultPadding / 2,
          ),
          Text.rich(TextSpan(children: [
            TextSpan(
                text: "Created Time: \n",
                style: Theme.of(context).textTheme.subtitle1),
            TextSpan(text: DateFormat.yMd().add_jm().format(
                controller.itemDetail!.createdTime!.toLocal())),
          ])),
          SizedBox(
            height: defaultPadding / 2,
          ),
          Text.rich(TextSpan(children: [
            TextSpan(
                text: "Last Updated Time: \n",
                style: Theme.of(context).textTheme.subtitle1),
            TextSpan(text: DateFormat.yMd().add_jm().format(
                controller.itemDetail!.lastUpdatedTime!.toLocal())),
          ])),
        ],
      );
    });
  }
}

class AddSupportLogDialog extends StatelessWidget {
  final AddNewSupportLogController controller = Get.find();
  final SupportMetricController smController = Get.find();
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
                        ...emailField(),
                        ...forEmailField(),
                        ...typeField(),
                        ...startAtField(),
                        ...endAtField(),
                        ...metricsField(),
                        ...observationsField(context),

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
                        if (controller.state is AddSupportLogFailure)
                          Padding(
                            padding: EdgeInsets.only(top: defaultPadding / 2),
                            child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  (controller.state as AddSupportLogFailure)
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
  List<Widget> forEmailField() {
    return <Widget>[
      TextFormField(
        style: TextStyle(
          color: Color(0xFF999999),
        ),
        decoration: InputDecoration(
          labelText: 'For Email',
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
        controller: controller.forEmailController,
        validator: (val) {
          if (val == "") {
            return 'For Email is required';
          }
          return null;
        },
      ),
      SizedBox(
        height: defaultPadding,
      ),
    ];
  }
  List<Widget> typeField() {
    return <Widget>[
      Text('Type:', style: TextStyle(fontWeight: FontWeight.bold)),
      SizedBox(height: defaultPadding / 3),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Radio(
            activeColor: Colors.deepPurpleAccent,
            value: "in_person",
            groupValue: controller.type.value,
            onChanged: (String? value) {
              controller.type.value = value!;
            },
          ),
          Text('In-person', style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(width: defaultPadding),
          Radio(
            activeColor: Colors.deepPurpleAccent,
            value: "online",
            groupValue: controller.type.value,
            onChanged: (String? value) {
              controller.type.value = value!;
            },
          ),
          Text('Online', style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
      SizedBox(
        height: defaultPadding,
      ),
    ];
  }
  List<Widget> startAtField() {
    return <Widget>[
      Text('Start At', style: TextStyle(fontWeight: FontWeight.bold)),
      SizedBox(height: defaultPadding / 2),
      Row(
        children: [
          Expanded(
              flex: 2,
              child: DatePickerField(
                controller: controller.startDateController,
                labelText: 'Date',
              )),
          SizedBox(width: defaultPadding / 2,),
          Expanded(
            child: TimePickerField(
              controller: controller.startTimeController,
              labelText: 'Time',
            ),
          )
        ],
      ),
      SizedBox(height: defaultPadding / 2),
    ];
  }
  List<Widget> endAtField() {
    return <Widget>[
      Text('End At', style: TextStyle(fontWeight: FontWeight.bold)),
      SizedBox(height: defaultPadding / 2),
      Row(
        children: [
          Expanded(
              flex: 2,
              child: DatePickerField(
                controller: controller.endDateController,
                labelText: 'Date',
              )),
          SizedBox(width: defaultPadding / 2,),
          Expanded(
            child: TimePickerField(
              controller: controller.endTimeController,
              labelText: 'Time',
            ),
          )
        ],
      ),
      SizedBox(height: defaultPadding / 2),
    ];
  }
  List<Widget> observationsField(BuildContext context) {
    return <Widget>[
      Text('Observations', style: TextStyle(fontWeight: FontWeight.bold)),
      SizedBox(height: defaultPadding / 2),
      ...controller.observations.asMap().entries.map((e) {
        return Column(
          children: [
            TextFormField(
              controller: controller.textControllers[e.key],
              cursorColor: Colors.white,
              readOnly: true,
              style: TextStyle(
                color: Color(0xFF999999),
              ),
              decoration: InputDecoration(
                labelText: "Time",
                labelStyle:
                TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.bold),
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
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
                hintStyle:
                TextStyle(color: Color(0xFF666666), fontWeight: FontWeight.bold),
              ),
              onTap: () async {
                TimeOfDay _time = TimeOfDay(hour: 9, minute: 0);
                if (controller.observations[e.key].time != null) {
                  _time = TimeOfDay.fromDateTime(controller.observations[e.key].time!.toLocal());
                }

                final TimeOfDay? newTime = await showTimePicker(
                  context: context,
                  initialTime: _time,
                  builder: (context, child) {
                    return Theme(
                      data: ThemeData(
                        colorScheme: ColorScheme.dark().copyWith(
                          primary: Colors.deepPurpleAccent,
                          onPrimary: Colors.white,
                          onSurface: Colors.white70,
                          surface: secondaryColor,
                        ),
                      ),
                      child: child!,
                    );
                  },
                );

                if (newTime != null) {
                  var now = DateTime.now();
                  controller.observations[e.key] = controller.observations[e.key].copyWith(
                    time: DateTime(now.year, now.month, now.day, newTime.hour, newTime.minute).toUtc(),
                  );
                  controller.textControllers[e.key].text = newTime.format(context);
                }
              },
              validator: (val) {
                if (val == null || val == '') return 'Required';
                return null;
              },
            ),
            SizedBox(
              height: defaultPadding / 2,
            ),
            TextFormField(
              style: TextStyle(
                color: Color(0xFF999999),
              ),
              decoration: InputDecoration(
                labelText: 'Description',
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
                ),
              ),
              cursorColor: Color(0xFF999999),
              minLines: 5,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              onChanged: (String? newVal) {
                controller.observations[e.key] =
                    controller.observations[e.key].copyWith(
                      description: newVal,
                    );
              },
              validator: (val) {
                if (val == "") {
                  return 'Description is required';
                }
                return null;
              },
            ),
            SizedBox(
              height: defaultPadding / 2,
            ),
          ],
        );
      }).toList(),
      SizedBox(
        height: defaultPadding / 2,
      ),
      Wrap(
        children: [
          TextButton.icon(
            style: TextButton.styleFrom(
              primary: Colors.deepPurpleAccent,
              padding: EdgeInsets.symmetric(
                  horizontal: defaultPadding, vertical: defaultPadding / 2),
            ),
            onPressed: () {
              controller.observations.add(Observation());
              controller.textControllers.add(TextEditingController());
            },
            icon: Icon(Icons.add),
            label: Text("Add New Observation"),
          ),
          if (controller.observations.length > 0)
            TextButton.icon(
              style: TextButton.styleFrom(
                primary: Colors.deepPurpleAccent,
                padding: EdgeInsets.symmetric(
                    horizontal: defaultPadding, vertical: defaultPadding / 2),
              ),
              onPressed: () {
                controller.observations.removeLast();
                controller.textControllers.removeLast();
              },
              icon: Icon(Icons.remove),
              label: Text("Remove Observation"),
            ),
        ],
      ),
      SizedBox(
        height: defaultPadding,
      ),
    ];
  }
  List<Widget> metricsField() {
    var metricList = <SupportMetric>[];
    if (smController.state is SupportMetricLoaded) {
      metricList =
          (smController.state as SupportMetricLoaded).listData ?? [];
    }

    return <Widget>[
      Text('Metrics', style: TextStyle(fontWeight: FontWeight.bold)),
      SizedBox(height: defaultPadding / 2),
      ...controller.metrics.asMap().entries.map((e) {
        return Column(
          children: [
            DropdownButtonFormField(
              items: metricList.map((e) {
                return DropdownMenuItem(
                  value: e.id,
                  child: Row(
                    children: [Text(e.name!.toUpperCase())],
                  ),
                );
              }).toList(),
              value: controller.metrics[e.key].metricId,
              onChanged: (String? newValue) {
                controller.metrics[e.key] = controller.metrics[e.key].copyWith(
                  metricId: newValue!,
                );
              },

              validator: (val) {
                if (val == null || val == "") {
                  return 'Required';
                }
                return null;
              },
              decoration: InputDecoration(
                  labelText: 'Metric',
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
              height: defaultPadding / 2,
            ),
            TextFormField(
              style: TextStyle(
                color: Color(0xFF999999),
              ),
              decoration: InputDecoration(
                labelText: 'Value',
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
                ),
              ),
              cursorColor: Color(0xFF999999),
              keyboardType: TextInputType.number,
              onChanged: (String? newVal) {
                controller.metrics[e.key] =
                    controller.metrics[e.key].copyWith(
                      value: int.tryParse(newVal!),
                    );
              },
              validator: (val) {
                if (val == null || val == "") {
                  return 'Value is required';
                }
                var value = int.tryParse(val);
                if (value == null) return 'Invalid input';
                return null;
              },
            ),
            SizedBox(
              height: defaultPadding / 2,
            ),
          ],
        );
      }).toList(),
      SizedBox(
        height: defaultPadding / 2,
      ),
      Row(
        children: [
          Expanded(
            child: TextButton.icon(
              style: TextButton.styleFrom(
                primary: Colors.deepPurpleAccent,
                padding: EdgeInsets.symmetric(
                    horizontal: defaultPadding, vertical: defaultPadding / 2),
              ),
              onPressed: () {
                controller.metrics.add(Metric());
              },
              icon: Icon(Icons.add),
              label: Text("Add New Metric"),
            ),
          ),
          if (controller.metrics.length > 0)
            Expanded(
              child: TextButton.icon(
                style: TextButton.styleFrom(
                  primary: Colors.deepPurpleAccent,
                  padding: EdgeInsets.symmetric(
                      horizontal: defaultPadding, vertical: defaultPadding / 2),
                ),
                onPressed: () {
                  controller.metrics.removeLast();
                },
                icon: Icon(Icons.remove),
                label: Text("Remove Metric"),
              ),
            ),
        ],
      ),
      SizedBox(
        height: defaultPadding,
      ),
    ];
  }
}

class EditSupportLogDialog extends StatelessWidget {
  final EditSupportLogController controller = Get.find();
  final SupportMetricController smController = Get.find();
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
                        ...emailField(),
                        ...forEmailField(),
                        ...typeField(),
                        ...startAtField(),
                        ...endAtField(),
                        ...metricsField(),
                        ...observationsField(context),

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
                        if (controller.state is EditSupportLogFailure)
                          Padding(
                            padding: EdgeInsets.only(top: defaultPadding / 2),
                            child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  (controller.state as EditSupportLogFailure)
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
  List<Widget> forEmailField() {
    return <Widget>[
      TextFormField(
        style: TextStyle(
          color: Color(0xFF999999),
        ),
        decoration: InputDecoration(
          labelText: 'For Email',
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
        controller: controller.forEmailController,
        validator: (val) {
          if (val == "") {
            return 'For Email is required';
          }
          return null;
        },
      ),
      SizedBox(
        height: defaultPadding,
      ),
    ];
  }
  List<Widget> typeField() {
    return <Widget>[
      Text('Type:', style: TextStyle(fontWeight: FontWeight.bold)),
      SizedBox(height: defaultPadding / 3),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Radio(
            activeColor: Colors.deepPurpleAccent,
            value: "in_person",
            groupValue: controller.type.value,
            onChanged: (String? value) {
              controller.type.value = value!;
            },
          ),
          Text('In-person', style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(width: defaultPadding),
          Radio(
            activeColor: Colors.deepPurpleAccent,
            value: "online",
            groupValue: controller.type.value,
            onChanged: (String? value) {
              controller.type.value = value!;
            },
          ),
          Text('Online', style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
      SizedBox(
        height: defaultPadding,
      ),
    ];
  }
  List<Widget> startAtField() {
    return <Widget>[
      Text('Start At', style: TextStyle(fontWeight: FontWeight.bold)),
      SizedBox(height: defaultPadding / 2),
      Row(
        children: [
          Expanded(
              flex: 2,
              child: DatePickerField(
                controller: controller.startDateController,
                labelText: 'Date',
              )),
          SizedBox(width: defaultPadding / 2,),
          Expanded(
            child: TimePickerField(
              controller: controller.startTimeController,
              labelText: 'Time',
            ),
          )
        ],
      ),
      SizedBox(height: defaultPadding / 2),
    ];
  }
  List<Widget> endAtField() {
    return <Widget>[
      Text('End At', style: TextStyle(fontWeight: FontWeight.bold)),
      SizedBox(height: defaultPadding / 2),
      Row(
        children: [
          Expanded(
              flex: 2,
              child: DatePickerField(
                controller: controller.endDateController,
                labelText: 'Date',
              )),
          SizedBox(width: defaultPadding / 2,),
          Expanded(
            child: TimePickerField(
              controller: controller.endTimeController,
              labelText: 'Time',
            ),
          )
        ],
      ),
      SizedBox(height: defaultPadding / 2),
    ];
  }
  List<Widget> observationsField(BuildContext context) {
    return <Widget>[
      Text('Observations', style: TextStyle(fontWeight: FontWeight.bold)),
      SizedBox(height: defaultPadding / 2),
      ...controller.observations.asMap().entries.map((e) {
        return Column(
          children: [
            TextFormField(
              controller: controller.textControllers[e.key],
              cursorColor: Colors.white,
              readOnly: true,
              style: TextStyle(
                color: Color(0xFF999999),
              ),
              decoration: InputDecoration(
                labelText: "Time",
                labelStyle:
                TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.bold),
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
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
                hintStyle:
                TextStyle(color: Color(0xFF666666), fontWeight: FontWeight.bold),
              ),
              onTap: () async {
                TimeOfDay _time = TimeOfDay(hour: 9, minute: 0);
                if (controller.observations[e.key].time != null) {
                  _time = TimeOfDay.fromDateTime(controller.observations[e.key].time!.toLocal());
                }

                final TimeOfDay? newTime = await showTimePicker(
                  context: context,
                  initialTime: _time,
                  builder: (context, child) {
                    return Theme(
                      data: ThemeData(
                        colorScheme: ColorScheme.dark().copyWith(
                          primary: Colors.deepPurpleAccent,
                          onPrimary: Colors.white,
                          onSurface: Colors.white70,
                          surface: secondaryColor,
                        ),
                      ),
                      child: child!,
                    );
                  },
                );

                if (newTime != null) {
                  var now = DateTime.now();
                  controller.observations[e.key] = controller.observations[e.key].copyWith(
                    time: DateTime(now.year, now.month, now.day, newTime.hour, newTime.minute).toUtc(),
                  );
                  controller.textControllers[e.key].text = newTime.format(context);
                }
              },
              validator: (val) {
                if (val == null || val == '') return 'Required';
                return null;
              },
            ),
            SizedBox(
              height: defaultPadding / 2,
            ),
            TextFormField(
              style: TextStyle(
                color: Color(0xFF999999),
              ),
              decoration: InputDecoration(
                labelText: 'Description',
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
                ),
              ),
              cursorColor: Color(0xFF999999),
              minLines: 5,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              initialValue: controller.observations[e.key].description,
              onChanged: (String? newVal) {
                controller.observations[e.key] =
                    controller.observations[e.key].copyWith(
                      description: newVal,
                    );
              },
              validator: (val) {
                if (val == "") {
                  return 'Description is required';
                }
                return null;
              },
            ),
            SizedBox(
              height: defaultPadding / 2,
            ),
          ],
        );
      }).toList(),
      SizedBox(
        height: defaultPadding / 2,
      ),
      Wrap(
        children: [
          TextButton.icon(
            style: TextButton.styleFrom(
              primary: Colors.deepPurpleAccent,
              padding: EdgeInsets.symmetric(
                  horizontal: defaultPadding, vertical: defaultPadding / 2),
            ),
            onPressed: () {
              controller.observations.add(Observation());
              controller.textControllers.add(TextEditingController());
            },
            icon: Icon(Icons.add),
            label: Text("Add New Observation"),
          ),
          if (controller.observations.length > 0)
            TextButton.icon(
              style: TextButton.styleFrom(
                primary: Colors.deepPurpleAccent,
                padding: EdgeInsets.symmetric(
                    horizontal: defaultPadding, vertical: defaultPadding / 2),
              ),
              onPressed: () {
                controller.observations.removeLast();
                controller.textControllers.removeLast();
              },
              icon: Icon(Icons.remove),
              label: Text("Remove Observation"),
            ),
        ],
      ),
      SizedBox(
        height: defaultPadding,
      ),
    ];
  }
  List<Widget> metricsField() {
    var metricList = <SupportMetric>[];
    if (smController.state is SupportMetricLoaded) {
      metricList =
          (smController.state as SupportMetricLoaded).listData ?? [];
    }

    return <Widget>[
      Text('Metrics', style: TextStyle(fontWeight: FontWeight.bold)),
      SizedBox(height: defaultPadding / 2),
      ...controller.metrics.asMap().entries.map((e) {
        return Column(
          children: [
            DropdownButtonFormField(
              items: metricList.map((e) {
                return DropdownMenuItem(
                  value: e.id,
                  child: Row(
                    children: [Text(e.name!.toUpperCase())],
                  ),
                );
              }).toList(),
              value: controller.metrics[e.key].metricId,
              onChanged: (String? newValue) {
                controller.metrics[e.key] = controller.metrics[e.key].copyWith(
                  metricId: newValue!,
                );
              },

              validator: (val) {
                if (val == null || val == "") {
                  return 'Required';
                }
                return null;
              },
              decoration: InputDecoration(
                  labelText: 'Metric',
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
              height: defaultPadding / 2,
            ),
            TextFormField(
              style: TextStyle(
                color: Color(0xFF999999),
              ),
              decoration: InputDecoration(
                labelText: 'Value',
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
                ),
              ),
              cursorColor: Color(0xFF999999),
              keyboardType: TextInputType.number,
              initialValue: controller.metrics[e.key].value.toString(),
              onChanged: (String? newVal) {
                controller.metrics[e.key] =
                    controller.metrics[e.key].copyWith(
                      value: int.tryParse(newVal!),
                    );
              },
              validator: (val) {
                if (val == null || val == "") {
                  return 'Value is required';
                }
                var value = int.tryParse(val);
                if (value == null) return 'Invalid input';
                return null;
              },
            ),
            SizedBox(
              height: defaultPadding / 2,
            ),
          ],
        );
      }).toList(),
      SizedBox(
        height: defaultPadding / 2,
      ),
      Row(
        children: [
          Expanded(
            child: TextButton.icon(
              style: TextButton.styleFrom(
                primary: Colors.deepPurpleAccent,
                padding: EdgeInsets.symmetric(
                    horizontal: defaultPadding, vertical: defaultPadding / 2),
              ),
              onPressed: () {
                controller.metrics.add(Metric());
              },
              icon: Icon(Icons.add),
              label: Text("Add New Metric"),
            ),
          ),
          if (controller.metrics.length > 0)
            Expanded(
              child: TextButton.icon(
                style: TextButton.styleFrom(
                  primary: Colors.deepPurpleAccent,
                  padding: EdgeInsets.symmetric(
                      horizontal: defaultPadding, vertical: defaultPadding / 2),
                ),
                onPressed: () {
                  controller.metrics.removeLast();
                },
                icon: Icon(Icons.remove),
                label: Text("Remove Metric"),
              ),
            ),
        ],
      ),
      SizedBox(
        height: defaultPadding,
      ),
    ];
  }
}