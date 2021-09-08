import 'package:flutter/material.dart';

const primaryColor = Colors.deepPurple;
const secondaryColor = Color(0xFF242430);
const darkColor = Color(0xFF191923);
const bodyTextColor = Color(0xFF8B8B8D);
// const bodyTextColor = Colors.yellowAccent;
const bgColor = Color(0xFF1E1E28);

const defaultPadding = 20.0;
// const maxWidth = 1440.0;

abstract class ApiStatus {
  static const Ok = 'OK';
  static const Error = 'ERROR';
  static const NotFound = 'NOT_FOUND';
  static const Unauthorized = 'UNAUTHORIZED';
  static const Forbidden = 'FORBIDDEN';
  static const BadRequest = 'BAD_REQUEST';
}