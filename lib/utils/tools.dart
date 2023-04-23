import 'dart:math';

import 'package:fluttertoast/fluttertoast.dart';

String generateRandomString(int len) {
  var r = Random();
  return String.fromCharCodes(List.generate(len, (index) => r.nextInt(33) + 89));
}