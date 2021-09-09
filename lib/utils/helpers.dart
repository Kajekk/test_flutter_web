import 'package:flutter/material.dart';

Map<String, dynamic>? parsedQuery(Map<String, dynamic>? query) {
  return query != null
      ? query.map((key, value) => MapEntry(key, value.toString()))
      : null;
}

String toTimeString(BuildContext context, int time) {
  var hour = time ~/ 60;
  var minute = time % 60;
  return TimeOfDay(hour: hour, minute: minute).format(context);
}

String getWeekDayString(weekday) {
  switch (weekday) {
    case 0:
      return 'Sun';
    case 1:
      return 'Mon';
    case 2:
      return 'Tue';
    case 3:
      return 'Wed';
    case 4:
      return 'Thur';
    case 5:
      return 'Fri';
    case 6:
      return 'Sat';
    case 7:
      return 'Sun';
    default:
      return 'Err';
  }
}