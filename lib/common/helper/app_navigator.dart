

import 'package:flutter/material.dart';

class AppNavigator {

  static Future<dynamic> push(BuildContext context, Widget widget) async {

    final value = await Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

    if(value != null) return value;

    return null;
  }

  static void pop(BuildContext context, [dynamic value]) {
    Navigator.pop(context, value);
  }

  static void pushReplacement(BuildContext context, Widget widget) {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => widget));
  }

  static void pushAndRemoveUntil(BuildContext context, Widget widget) {
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => widget), (Route<dynamic> route) => false);
  }
}