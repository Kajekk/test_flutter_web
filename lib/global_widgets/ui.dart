import 'dart:math';

import 'package:flutter/material.dart';

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
      setState(() {
      });
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