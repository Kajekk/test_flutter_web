import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:test_flutter_web/constants/barrel.dart';

class DotWaveLoader extends StatefulWidget {
  final Color dotColor;
  final Duration duration;
  final Icon dotIcon;
  final DotType dotType;

  const DotWaveLoader({
    this.duration = const Duration(milliseconds: 1000),
    this.dotIcon = const Icon(Icons.blur_on),
    this.dotType = DotType.circle,
    this.dotColor = Colors.black,
  });

  @override
  _DotWaveLoaderState createState() => _DotWaveLoaderState();
}

class _DotWaveLoaderState extends State<DotWaveLoader>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation_1;
  late Animation<double> animation_2;
  late Animation<double> animation_3;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(duration: widget.duration, vsync: this);

    animation_1 = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0.0, 0.70, curve: Curves.linear),
      ),
    );

    animation_2 = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0.1, 0.80, curve: Curves.linear),
      ),
    );

    animation_3 = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0.2, 0.90, curve: Curves.linear),
      ),
    );

    controller.addListener(() {
      setState(() {});
    });

    controller.repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Opacity(
              opacity: animation_1.value <= 0.4
                  ? 2.5 * animation_1.value
                  : (animation_1.value > 0.40 && animation_1.value <= 0.60)
                      ? 1.0
                      : 2.5 - (2.5 * animation_1.value),
              child: Padding(
                padding: const EdgeInsets.only(right: 5.0),
                child: Dot(
                  radius: 10.0,
                  color: widget.dotColor,
                  type: widget.dotType,
                  icon: widget.dotIcon,
                ),
              )),
          Opacity(
            opacity: (animation_2.value <= 0.4
                ? 2.5 * animation_2.value
                : (animation_2.value > 0.40 && animation_2.value <= 0.60)
                    ? 1.0
                    : 2.5 - (2.5 * animation_2.value)),
            child: Padding(
              padding: const EdgeInsets.only(right: 5.0),
              child: Dot(
                radius: 10.0,
                color: widget.dotColor,
                type: widget.dotType,
                icon: widget.dotIcon,
              ),
            ),
          ),
          Opacity(
            opacity: (animation_3.value <= 0.4
                ? 2.5 * animation_3.value
                : (animation_3.value > 0.40 && animation_3.value <= 0.60)
                    ? 1.0
                    : 2.5 - (2.5 * animation_3.value)),
            child: Padding(
              padding: const EdgeInsets.only(right: 5.0),
              child: Dot(
                radius: 10.0,
                color: widget.dotColor,
                type: widget.dotType,
                icon: widget.dotIcon,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

enum DotType { square, circle, diamond, icon }

class Dot extends StatelessWidget {
  final double? radius;
  final Color? color;
  final DotType? type;
  final Icon? icon;

  Dot({this.radius, this.color, this.type, this.icon});

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: type == DotType.icon
          ? Icon(
              icon!.icon,
              color: color,
              size: 1.3 * radius!,
            )
          : new Transform.rotate(
              angle: type == DotType.diamond ? pi / 4 : 0.0,
              child: Container(
                width: radius,
                height: radius,
                decoration: BoxDecoration(
                    color: color,
                    shape: type == DotType.circle
                        ? BoxShape.circle
                        : BoxShape.rectangle),
              ),
            ),
    );
  }
}

class TimePickerField extends StatefulWidget {
  const TimePickerField(
      {Key? key,
      required this.controller,
      this.labelText = '',
      this.isRequireValidate = true})
      : super(key: key);
  final TextEditingController controller;
  final String labelText;
  final bool isRequireValidate;

  @override
  _TimePickerFieldState createState() => _TimePickerFieldState();
}

class _TimePickerFieldState extends State<TimePickerField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      cursorColor: Colors.white,
      readOnly: true,
      style: TextStyle(
        color: Color(0xFF999999),
      ),
      decoration: InputDecoration(
        labelText: widget.labelText,
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
      onTap: _selectTime,
      validator: widget.isRequireValidate
          ? (val) {
              if (val == null || val == '') return 'Required';
              return null;
            }
          : null,
    );
  }

  void _selectTime() async {
    TimeOfDay _time = TimeOfDay(hour: 9, minute: 0);
    if (widget.controller.text.isNotEmpty) {
      var format = DateFormat.jm();
      _time = TimeOfDay.fromDateTime(format.parse(widget.controller.text));
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
      setState(() {
        widget.controller.text = newTime.format(context);
      });
    }
  }
}

class DatePickerField extends StatefulWidget {
  const DatePickerField(
      {Key? key,
      required this.controller,
      this.labelText = '',
      this.isRequireValidate = true})
      : super(key: key);
  final TextEditingController controller;
  final String labelText;
  final bool isRequireValidate;

  @override
  _DatePickerFieldState createState() => _DatePickerFieldState();
}

class _DatePickerFieldState extends State<DatePickerField> {
  var selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      cursorColor: Colors.white,
      readOnly: true,
      style: TextStyle(
        color: Color(0xFF999999),
      ),
      decoration: InputDecoration(
        labelText: widget.labelText,
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
        suffixIcon: Icon(Icons.date_range, color: Color(0xFF999999)),
      ),
      onTap: _selectDate,
      validator: widget.isRequireValidate
          ? (val) {
              if (val == null || val == '') return 'Required';
              return null;
            }
          : null,
    );
  }

  void _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: ThemeData(
            textSelectionTheme: TextSelectionThemeData(
                cursorColor: Colors.white,
                selectionColor: Colors.blueAccent
            ),
            inputDecorationTheme: InputDecorationTheme(
              labelStyle: TextStyle(color: Color(0xFF9FA8DA)),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFF9FA8DA),
                ),
              ),
            ),
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
    if (picked != null && picked != selectedDate)
      setState(() {
        widget.controller.text = DateFormat.yMd().format(picked);
        selectedDate = picked;
      });
  }
}
